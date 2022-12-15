{-# LANGUAGE OverloadedStrings #-}
module Main where
import Network.Socket
import Network.Socket.ByteString (recv, sendAll)
import qualified Control.Exception as E
import qualified Data.ByteString as C
import qualified Data.Text as T
import qualified Data.Text.Encoding as T

main :: IO ()
main = runTCPClient "127.0.0.1" "2000" event_loop

event_loop(s) = do
  msg <- readInput
  sendAll s $ T.encodeUtf8 . T.pack $ msg
  resp <- recv s 1024
  putStr "Received: "
  C.putStr resp
  event_loop s

runTCPClient :: HostName -> ServiceName -> (Socket -> IO a) -> IO a
runTCPClient host port client = withSocketsDo $ do
    addr <- resolve
    E.bracket (open addr) close client
  where
    resolve = do
        let hints = defaultHints { addrSocketType = Stream }
        head <$> getAddrInfo (Just hints) (Just host) (Just port)
    open addr = E.bracketOnError (openSocket addr) close $ \sock -> do
        connect sock $ addrAddress addr
        return sock

readInput = do
  putStrLn "Input a char: "
  inp <- getLine
  if length inp == 1
    then return inp
    else must_char

must_char = do
  putStrLn "Input must be a char"
  readInput
