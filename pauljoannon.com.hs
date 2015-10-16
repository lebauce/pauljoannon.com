-- -------------------------------------------------------------------------------------------------

{-# LANGUAGE OverloadedStrings #-}

import Hakyll
import Data.Monoid (mconcat)

-- -------------------------------------------------------------------------------------------------

main :: IO ()
main = do
    hakyllWith configuration $ do
        -- Copy static assets
        match (foldr1 (.||.) ["CNAME", "css/fonts/*", "content/mustache.svg", "content/portfolio/*.jpg"]) $ do
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
        includeField "content" "portfolio"
    ]

portfolioContext :: Context String
portfolioContext = mconcat
    [
        defaultContext,
        listField "items" defaultContext (recentFirst =<< loadAllSnapshots "content/portfolio/*.md" "content")
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
        deployCommand = "cd _site && rm -rf .git && git init && cp ../.git/config .git/ && git add * && git commit -m ':shipit:' && git push origin +master:gh-pages"
    }
