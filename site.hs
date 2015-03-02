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
        let assets = [ "CNAME", "assets/images/*", "assets/images/projects/*", "assets/js/**",
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
                    >>= relativizeUrls

        -- Compile About
        match "content/about.md" $ do
            compile $ do
                pandocCompiler
                    >>= loadAndApplyTemplate "templates/about.html" defaultContext
                    >>= saveSnapshot "content"

        -- Compile Projects
        create ["content/projects.md"] $ do
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
    , includeField "about"
    , includeField "projects"
    ]

projectsCtx :: Context String
projectsCtx = mconcat
    [ defaultContext
    , titleField "Projets"
    , listField "projects" defaultContext (recentFirst =<< loadAllSnapshots "content/projects/*.md" "content")
    ]

-- ------------------------------------------------------------------------------
-- Fields

-- A field containing a 'content' snapshot
includeField :: String -> Context a
includeField name = field name $ \_ -> do
    include <- loadSnapshot (fromFilePath $ "content/" ++ name ++ ".md") "content"
    return $ itemBody include

-- ------------------------------------------------------------------------------
-- Compilers

-- Compile a .less file to .css
lessCompiler :: Compiler (Item String)
lessCompiler =
    getResourceString
        >>= withItemBody (unixFilter "lessc" ["--compress --include-path=./assets/css/:./assets/vendor/", "-"])
        >>= return . fmap compressCss

-- ------------------------------------------------------------------------------
-- Helpers

-- ------------------------------------------------------------------------------
-- Configurations
