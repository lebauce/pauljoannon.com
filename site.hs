-- ------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}

import Hakyll
import Data.Monoid (mconcat)

-- ------------------------------------------------------------------------------

main :: IO ()
main = do

    hakyll $ do

        -- Compile templates
        match "templates/*" $ compile templateCompiler

        -- Copy static assets
        let assets = [ "CNAME", "assets/images/*", "assets/js/**",
                       "assets/vendor/**/*.min.js", "assets/vendor/fontawesome/fonts/*" ]
        match (foldr1 (.||.) assets) $ do
            route idRoute
            compile copyFileCompiler

        -- Compile less
        match "assets/css/default.less" $ do
            route $ setExtension "css"
            compile lessCompiler

        -- Compile Index
        create ["index.html"] $ do
            route idRoute
            compile $ do
                makeItem ""
                    >>= loadAndApplyTemplate "templates/index.html" indexCtx
                    >>= loadAndApplyTemplate "templates/base.html"  indexCtx
                    >>= relativizeUrls

        -- Compile About
        match "content/about.md" $ do
            compile $ do
                pandocCompiler
                    >>= loadAndApplyTemplate "templates/about.html" defaultContext
                    >>= saveSnapshot "content"

        -- Compile Projects
        create ["content/projects.html"] $ do
            compile $ do
                makeItem ""
                    >>= loadAndApplyTemplate "templates/projects.html" projectsCtx
                    >>= saveSnapshot "content"

        -- Compile all Projects
        match "content/projects/*.md" $ do
            compile $ do
                pandocCompiler
                    >>= loadAndApplyTemplate "templates/project.html" defaultContext
                    >>= saveSnapshot "content"

-- ------------------------------------------------------------------------------
-- Contexts

indexCtx :: Context String
indexCtx = mconcat
    [ defaultContext
    , titleField "Paul Joannon"
    , constField "subtitle" "aka Paulloz"
    , constField "twitter" "@pauljoannon"
    , constField "github" "Paulloz"
    , aboutField
    , projectsField
    ]

projectsCtx :: Context String
projectsCtx = mconcat
    [ listField "projects" defaultContext (loadAllSnapshots "content/projects/*.md" "content")
    , defaultContext
    ]

-- ------------------------------------------------------------------------------
-- Fields

-- A field containing the 'content' snapshot of 'apropos.md'
aboutField :: Context a
aboutField = field "about" $ \_ -> do
    about <- loadSnapshot "content/about.md" "content"
    return $ itemBody about

projectsField :: Context a
projectsField = field "projects" $ \_ -> do
    projects <- loadSnapshot "content/projects.html" "content"
    return $ itemBody projects

-- ------------------------------------------------------------------------------
-- Compilers

-- Compile a .less file to .css
lessCompiler :: Compiler (Item String)
lessCompiler =
    getResourceString
        >>= withItemBody (unixFilter "lessc" ["--include-path=./assets/css/:./assets/vendor/", "-"])
        >>= return . fmap compressCss

-- ------------------------------------------------------------------------------
-- Helpers

-- ------------------------------------------------------------------------------
-- Configurations
