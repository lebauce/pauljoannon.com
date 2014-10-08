-- ------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}

import Hakyll
import Control.Applicative
import Data.Monoid (mappend, mconcat)
import Data.Time.Clock
import Data.Time.Calendar
import Data.Tuple.Select

-- ------------------------------------------------------------------------------

main :: IO ()
main = do
    now <- getCurrentTime

    hakyll $ do

        let baseContext =
                constField "site_title" "pauljoannon.com" `mappend`
                constField "current_year" (show (sel1 (toGregorian $ utctDay now))) `mappend`
                defaultContext

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

        -- Compile the home page
        create ["index.md"] $ do
            route $ setExtension "html"
            compile $ do
                let indexContext =
                        titleField "pauljoannon.com" `mappend`
                        baseContext
                pandocCompiler
                    >>= loadAndApplyTemplate "templates/index.html" indexContext
                    >>= loadAndApplyTemplate "templates/base.html"  indexContext
                    >>= relativizeUrls

-- ------------------------------------------------------------------------------
-- Contexts

-- ------------------------------------------------------------------------------
-- Compilers

-- Compile a .less file to .css
lessCompiler :: Compiler (Item String)
lessCompiler =
    getResourceString
        >>= withItemBody (unixFilter "lessc" ["--include-path=assets/css/:assets/vendor/", "-"])
        >>= return . fmap compressCss

-- ------------------------------------------------------------------------------
-- Helpers

-- ------------------------------------------------------------------------------
-- Configurations
