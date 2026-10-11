module Main (main) where

import Control.Arrow
import Data.Char
import Data.List
import Text.Regex.TDFA

count1 :: [String] -> Int
count1 = fmap calibration >>> sum where
  calibration = filter isDigit >>> (\nums -> read ([head nums, last nums]))

numbers :: [String]
numbers =
  [ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"
  , "1", "2", "3", "4", "5", "6", "7", "8", "9"
  ]
numbersPattern :: String
numbersPattern = concat (intersperse "|" numbers)

count2 :: [String] -> Maybe Int
count2 = fmap sum . sequenceA . fmap (calibration . matches) where
  calibration (v1, v2) = (+) <$> ((*10) <$> mapping v1) <*> mapping v2

mapping str = ((flip mod 9) >>> (+1)) <$> (elemIndex str numbers)
matches str =
  ( str =~ numbersPattern :: String
  , reverse ((reverse str) =~ (reverse numbersPattern) :: String)
  )

main :: IO ()
main = do
  input <- readFile "input2.txt"
  count <- return $ count2 $ lines input
  print count
