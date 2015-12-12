-- -------------------------------------------------------------------------------------------------

{-# LANGUAGE OverloadedStrings #-}

import Hakyll
import Data.Monoid (mconcat)
import System.FilePath
import Control.Monad (forM_, forM)
import Data.List (intercalate, sort)
import Text.Blaze.Html (toHtml, toValue, (!))
import Text.Blaze.Html.Renderer.String (renderHtml)
import qualified Data.Map as M
import qualified Text.Blaze.Html5                as H
import qualified Text.Blaze.Html5.Attributes     as A

-- -------------------------------------------------------------------------------------------------

type Year = String
type Month = String
type Archive = ((Year, Month), Int)
type Archives = [Archive]

-- -------------------------------------------------------------------------------------------------

main :: IO ()
main = do
    hakyllWith configuration $ do
        -- Build tags
        tags <- buildTags "content/blog/**/*.md" (fromCapture "blog/tags/*.html")
        archives <- buildArchives "content/blog/**/*.md"

        -- Copy static assets
        let assets = ["CNAME", "css/fonts/*", "content/mustache.svg", "content/social.jpg",
                      "content/**/*.jpg", "content/**/*.gif", "content/favicon.*"]
        match (foldr1 (.||.) assets) $ do
            route idRoute
            compile copyFileCompiler

        -- Compile templates
        match "templates/*" $ compile templateCompiler

        -- Compile less
        match "css/main.less" $ do
            route $ setExtension "css"
            compile lessCompiler

        -- Compile es6
        match "js/*.es6" $ do
            route $ setExtension "js"
            compile babelCompiler

        -- Compile index
        match (fromList ["content/index.md", "content/en/index.md"]) $ do
            route $ gsubRoute "content/" (const "") `composeRoutes` setExtension "html"
            compile $ do
                pandocCompiler
                    >>= loadAndApplyTemplate "templates/index.html" indexContext
                    >>= relativizeUrls

        -- Compile portfolio
        create ["content/portfolio.md"] $ do
            compile $ do
                makeItem ""
                    >>= loadAndApplyTemplate "templates/portfolio.html" portfolioContext
                    >>= saveSnapshot "content"

        match "content/portfolio/*.md" $ do
            compile $ do
                pandocCompiler
                    >>= loadAndApplyTemplate "templates/portfolio-item.html" defaultContext
                    >>= saveSnapshot "content"

        -- Compile blog
        match "content/blog/**/*.md" $ do
            route $ gsubRoute "content/" (const "") `composeRoutes` setExtension "html"
            compile $ do
                pandocCompiler
                    >>= saveSnapshot "content"
                    >>= loadAndApplyTemplate "templates/blog-entry.html" (blogEntryContext tags archives)
                    >>= relativizeUrls

        match "content/blog/index.md" $ do
            route $ gsubRoute "content/" (const "") `composeRoutes` setExtension "html"
            compile $ do
                pandocCompiler
                    >>= loadAndApplyTemplate "templates/blog.html" (blogContext tags archives)
                    >>= relativizeUrls

        tagsRules tags $ \tag pattern -> do
            route idRoute
            compile $ do
                makeItem ""
                    >>= loadAndApplyTemplate "templates/blog.html" (blogTagContext pattern tags archives tag)
                    >>= relativizeUrls

        forM_ archives $ \archive ->
            create [(archiveId $ fst archive)] $ do
                route idRoute
                compile $ do
                    makeItem ""
                        >>= loadAndApplyTemplate "templates/blog.html" (blogArchiveContext (fst archive) tags archives)
                        >>= relativizeUrls

-- -------------------------------------------------------------------------------------------------
-- Compilers

lessCompiler :: Compiler (Item String)
lessCompiler =
    getResourceString
        >>= withItemBody (unixFilter "lessc" ["--include-path=./css/", "-"])
        >>= return . fmap compressCss

babelCompiler :: Compiler (Item String)
babelCompiler =
    getResourceString
        >>= withItemBody (unixFilter "babel" [])
        >>= return

-- -------------------------------------------------------------------------------------------------
-- Contexts

indexContext :: Context String
indexContext = mconcat
    [
        defaultContext,
        constField "main-title" "Paul&nbsp;Joannon",
        constField "main-url" "/",
        includeField "content" "portfolio"
    ]

portfolioContext :: Context String
portfolioContext = mconcat
    [
        defaultContext,
        listField "items" defaultContext (recentFirst =<< loadAllSnapshots "content/portfolio/*.md" "content")
    ]

blogEntryContext :: Tags -> Archives -> Context String
blogEntryContext tags archives = mconcat
    [
        defaultContext,
        constField "main-title" "Paulloz&nbsp;:&nbsp;le&nbsp;blog",
        constField "main-url" "/blog",
        field "all-the-tags" (\_ -> renderTagList tags),
        field "all-the-archives" (\_ -> renderArchives archives),
        teaserField "teaser" "content",
        tagsField "tags-list" tags
    ]

blogContext :: Tags -> Archives -> Context String
blogContext tags archives = mconcat
    [
        blogEntryContext tags archives,
        listField "entries" (blogEntryContext tags archives) (recentFirst =<< loadAllSnapshots "content/blog/**/*.md" "content")
    ]

blogArchiveContext :: (Year, Month) -> Tags -> Archives -> Context String
blogArchiveContext (year, month) tags archives = mconcat
    [
        blogEntryContext tags archives,
        listField "entries" (blogEntryContext tags archives) (recentFirst =<< loadAllSnapshots (fromGlob $ "content/blog/" ++ year ++ "/" ++ month ++ "/*.md") "content")
    ]

blogTagContext :: Pattern -> Tags -> Archives -> String -> Context String
blogTagContext pattern tags archives tag = mconcat
    [
        blogEntryContext tags archives,
        constField "tag" tag,
        listField "entries" (blogEntryContext tags archives) (recentFirst =<< loadAllSnapshots pattern "content")
    ]

-- -------------------------------------------------------------------------------------------------
-- Fields

includeField :: String -> String -> Context a
includeField fName name = field fName $ \_ -> do
    include <- loadSnapshot (fromFilePath $ "content/" ++ name ++ ".md") "content"
    return $ itemBody include

-- -------------------------------------------------------------------------------------------------
-- Configurations

configuration :: Configuration
configuration = defaultConfiguration
    {
        previewHost = "0.0.0.0",
        deployCommand = "cd _site && rm -rf .git && git init && cp ../.git/config .git/ && git add * && git commit -m ':shipit:' && git push origin +master:gh-pages"
    }

-- -------------------------------------------------------------------------------------------------
-- Utils

renderArchives :: Archives -> Compiler String
renderArchives archives = do
    archives' <- forM (reverse . sort $ archives) $ \((year, month), count) -> do
        route' <- getRoute $ archiveId (year, month)
        return ((year, month), route', count)
    return . intercalate ", " $ map makeLink archives'
    where
        makeLink ((year, month), route', count) =
            (renderHtml (H.a ! A.href (archiveUrl (year, month)) $ toHtml $ fullText ((year, month), count) ))
        fullText ((year, month), count) = year ++ "-" ++ month ++ " (" ++ show count ++ ")"
        archiveUrl = toValue . toUrl . archivePath


buildArchives :: MonadMetadata m => Pattern -> m Archives
buildArchives pattern = do
    ids <- getMatches pattern
    return . frequency . (map getMonthAndYear) $ ids
    where
        frequency xs = M.toList (M.fromListWith (+) [(x, 1) | x <- xs])

getMonthAndYear :: Identifier -> (Year, Month)
getMonthAndYear id = ((getYear id), (getMonth id))

getYear :: Identifier -> Year
getYear = takeBaseName . takeDirectory . takeDirectory . toFilePath

getMonth :: Identifier -> Month
getMonth = takeBaseName . takeDirectory . toFilePath

archivePath :: (Year, Month) -> FilePath
archivePath (year, month) = "blog/" ++ year ++ "/" ++ month ++ "/index.html"

archiveId :: (Year, Month) -> Identifier
archiveId = fromFilePath . archivePath
