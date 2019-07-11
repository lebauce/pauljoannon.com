{-# LANGUAGE OverloadedStrings #-}

import Hakyll
import Data.Monoid ((<>))

-- -------------------------------------------------------------------------------------------------

main :: IO ()
main = do
    hakyllWith configuration $ do
        -- Copy static assets
        match ("CNAME" .||. "css/fonts/*" .||. "content/mustache.svg" .||. "content/social.jpg" .||.
               "content/portfolio/*.jpg" .||. "content/favicon.*" .||. "content/cv/pjoannon.jpg") $ do
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
        match "content/index.md" $ do
            route $ gsubRoute "content/" (const "") `composeRoutes` setExtension "html"
            compile $ do
                let ctx = includeField "content" "portfolio" <> mainContext
                pandocCompiler
                    >>= loadAndApplyTemplate "templates/index.html" ctx
                    >>= relativizeUrls

        -- Compile portfolio
        create ["content/portfolio.md"] $ do
            compile $ do
                let ctx =
                        listField "items" defaultContext (recentFirst =<< loadAllSnapshots "content/portfolio/*.md" "content") <>
                        defaultContext
                makeItem ""
                    >>= loadAndApplyTemplate "templates/portfolio.html" ctx
                    >>= saveSnapshot "content"

        match "content/portfolio/*.md" $ do
            compile $ do
                pandocCompiler
                    >>= loadAndApplyTemplate "templates/portfolio-item.html" defaultContext
                    >>= saveSnapshot "content"

        -- Compile curriculum
        match (fromList ["content/cv/en.md", "content/cv/fr.md"]) $ do
            route $ gsubRoute "content/" (const "") `composeRoutes` setExtension "html"
            compile $ do
                let ctx =
                        includeField "skills" "cv/en/skills" <>
                        includeField "experience" "cv/en/experience" <>
                        includeField "personnal-projects" "cv/en/personnal-projects" <>
                        includeField "school" "cv/en/school" <>
                        cvContext
                pandocCompiler
                    >>= loadAndApplyTemplate "templates/cv.html" ctx
                    >>= relativizeUrls

        match "content/cv/**/*.md" $ do
            compile $ do
                pandocCompiler
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

mainContext :: Context String
mainContext =
        constField "main-title" "Paul&nbsp;Joannon" <>
        constField "main-url" "/" <>
        defaultContext

cvContext :: Context String
cvContext = mainContext

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
        deployCommand = "\
        \  echo Cleaning...                                                 ; \
        \ (stack exec pauljoannon -- clean > /dev/null)                     ; \
        \  echo Building website...                                         ; \
        \ (stack exec pauljoannon -- build > /dev/null)                     ; \
        \  echo Removing unnecessary files...                               ; \
        \  rm -rf _site/cv/ _site/content/cv/                               ; \
        \  echo Switching to gh-pages...                                    ; \
        \  git fetch -q origin                                              ; \
        \ (git branch -q -D gh-pages 2> /dev/null)                          ; \
        \ (git checkout -q -b gh-pages --track origin/gh-pages > /dev/null) ; \
        \  rsync -a --delete --exclude _site                                  \
        \                    --exclude _cache                                 \
        \                    --exclude .stack-work                            \
        \                    --exclude .gitignore                             \
        \                    --exclude .git                                   \
        \                    _site/ .                                       ; \
        \  git add -A                                                       ; \
        \ (git commit -m ':shipit:' > /dev/null)                            ; \
        \  echo Deploying on GitHub pages...                                ; \
        \ (git push origin gh-pages:gh-pages > /dev/null)                   ; \
        \  echo Done.                                                       ; \
        \  echo Cleaning the mess...                                        ; \
        \  git checkout -q master                                           ; \
        \ (git branch -q -D gh-pages 2> /dev/null)                          ; \
        \ (stack exec pauljoannon -- clean > /dev/null)                     ; \
        \  echo 'Goodbye! :)'                                                 \
        \ "
    }