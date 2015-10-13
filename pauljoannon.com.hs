-- -------------------------------------------------------------------------------------------------

{-# LANGUAGE OverloadedStrings #-}

import Hakyll

-- -------------------------------------------------------------------------------------------------

main :: IO ()
main = do
    hakyll $ do
        -- Copy static assets
        match (foldr1 (.||.) ["CNAME", "css/fonts/*", "content/mustache.svg"]) $ do
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
                    >>= loadAndApplyTemplate "templates/index.html" defaultContext
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
