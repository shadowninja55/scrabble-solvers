<?php
function valid($word, $letters) {
    for ($i = 0; $i < strlen($word); $i++) {
        $c = $word[$i];
        if (substr_count($word, $c) > substr_count($letters, $c)) {
            return false;
        }
    }
    return true;
}

function generate_words($letters) {
    $words = [];

    $text = file_get_contents('dictionary.txt');
    $dictionary = explode("\r\n", $text);
    foreach ($dictionary as $word) {
        if (valid($word, $letters)) {
            array_push($words, $word);
        }
    }

    return $words;
}

function score($word) {
    $word = str_split($word);
    $scores = array (
        "a" => 1 , "b" => 3 , "c" => 3 , "d" => 2 ,
        "e" => 1 , "f" => 4 , "g" => 2 , "h" => 4 ,
        "i" => 1 , "j" => 8 , "k" => 5 , "l" => 1 ,
        "m" => 3 , "n" => 1 , "o" => 1 , "p" => 3 ,
        "q" => 10, "r" => 1 , "s" => 1 , "t" => 1 ,
        "u" => 1 , "v" => 4 , "w" => 4 , "x" => 8 ,
        "y" => 4 , "z" => 10
    );

    $score = 0;
    foreach ($word as $c) {
        $score += $scores[$c];
    }

    return $score;
}

function sorted($words) {
    usort($words, function ($first, $second) {
        return score($first) > score($second);
    });
    return $words;
}

function display($words) {
    $result = '';

    for ($i = count($words); $i > 0; $i--) {
        $index = count($words) - $i;
        $result .= ($i.'. '.$words[$index]."\n");
    }
    return $result;
}

function main() {
    echo "\n";
    $letters = "abcdefg"; // readline("Letters: ");
    $words = generate_words($letters);
    $words = sorted($words);
    $result = display($words);
    echo $result;
}

main();
?>
