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
        let assets = [ "images/*", "js/**" ]
        match (foldr1 (.||.) assets) $ do
            route idRoute
            compile copyFileCompiler

        -- Compile less
        match "css/*" $ do
            route $ setExtension "css"
            compile lessCompiler

        -- Compile the home page
        match "index.md" $ do
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
        >>= withItemBody (unixFilter "lessc" ["--include-path=css/:bower_components/", "-"])
        >>= return . fmap compressCss

-- ------------------------------------------------------------------------------
-- Helpers

-- ------------------------------------------------------------------------------
-- Configurations
