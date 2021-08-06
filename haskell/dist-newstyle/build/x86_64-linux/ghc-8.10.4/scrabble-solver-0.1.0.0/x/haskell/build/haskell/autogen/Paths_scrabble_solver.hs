{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_scrabble_solver (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/mark/.cabal/bin"
libdir     = "/home/mark/.cabal/lib/x86_64-linux-ghc-8.10.4/scrabble-solver-0.1.0.0-inplace-haskell"
dynlibdir  = "/home/mark/.cabal/lib/x86_64-linux-ghc-8.10.4"
datadir    = "/home/mark/.cabal/share/x86_64-linux-ghc-8.10.4/scrabble-solver-0.1.0.0"
libexecdir = "/home/mark/.cabal/libexec/x86_64-linux-ghc-8.10.4/scrabble-solver-0.1.0.0"
sysconfdir = "/home/mark/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "scrabble_solver_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "scrabble_solver_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "scrabble_solver_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "scrabble_solver_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "scrabble_solver_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "scrabble_solver_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
