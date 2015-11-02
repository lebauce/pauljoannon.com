-- -------------------------------------------------------------------------------------------------

{-# LANGUAGE OverloadedStrings #-}

import Hakyll
import Data.Monoid (mconcat)

-- -------------------------------------------------------------------------------------------------

main :: IO ()
main = do
    hakyllWith configuration $ do
        -- Build tags
        tags <- buildTags "content/blog/**/*.md" (fromCapture "blog/tags/*.html")

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
        create ["content/portfolio.md"] $  do
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
                    >>= loadAndApplyTemplate "templates/blog-entry.html" (blogEntryContext tags)
                    >>= relativizeUrls

        create ["content/blog/index.md"] $ do
            route $ gsubRoute "content/" (const "") `composeRoutes` setExtension "html"
            compile $ do
                makeItem ""
                    >>= loadAndApplyTemplate "templates/blog.html" (blogContext tags)
                    >>= relativizeUrls

        tagsRules tags $ \tag pattern -> do
            route idRoute
            compile $ do
                makeItem ""
                    >>= loadAndApplyTemplate "templates/blog.html" (blogTagContext pattern tags tag)
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

blogEntryContext :: Tags -> Context String
blogEntryContext tags = mconcat
    [
        defaultContext,
        constField "main-title" "Paulloz&nbsp;:&nbsp;le&nbsp;blog",
        constField "main-url" "/blog",
        field "all-the-tags" (\_ -> renderTagList tags),
        teaserField "teaser" "content",
        tagsField "tags-list" tags
    ]

blogContext :: Tags -> Context String
blogContext tags = mconcat
    [
        blogEntryContext tags,
        listField "entries" (blogEntryContext tags) (recentFirst =<< loadAllSnapshots "content/blog/**/*.md" "content")
    ]

blogTagContext :: Pattern -> Tags -> String -> Context String
blogTagContext pattern tags tag = mconcat
    [
        blogEntryContext tags,
        constField "tag" tag,
        listField "entries" (blogEntryContext tags) (recentFirst =<< loadAllSnapshots pattern "content")
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
