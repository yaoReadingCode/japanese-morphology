#!/usr/bin/ruby1.9
# encoding: utf-8

require 'set'

$Lpunctuation = Set.new ["。", "？", "、", "「", "」", "／", "◎", "．", "．．．", "・", "・・", "・・・", "・・・・", "・・・・・", "………", "……", "（", "）", "！", "＆", "“", "…", "…………", "？？", "？？？", "！！", "！！！", "！！！！", "！！！！！", "！！！！！！！！", "、、", "、、、", "、、、、", "、、、、、、、、", "、、、、、、", "、、、、、、", "、、、、、、、、", "・・・・", "！！！！！！", "！！！！！！！！！！！！", "＊", "≒", "〇", "〇〇", "○", "○○", "●", "●●", "★", "★★", "★★★", "★★★★", "★★★★★", "☆", "☆☆", "☆☆☆", "☆☆☆☆", "☆☆☆☆☆", "—", "〜", "，", "。。", "。。。", "。。。。", "。。。。。", "♪", "♪♪", "♪♪♪", "♪♪♪♪", "♪♪♪♪♪", "『", "』", "”", "：", "＜", "＜＜", "＜＜＜", "＞", "＞＞", "＞＞＞", "←", "→", "＋", "↑", "↑↑", "↓", "↓↓", "−", "−−−", "＝", "×", "××", "〓", "〓〓", "〓〓〓", "■", "■■", "■■■", "（＞◆＜）", "＋＿＋", "（＾＾；）", "（＊＾−＾＊）", "（＞▽＜）", "＾＾；", "（＾□＾；）", "＾＾", "（−＿−；）", "＾＾；）", "（＞＜）", "＞＜"]

$Larabnum = Set.new ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "０", "１", "２", "３", "４", "５", "６", "７", "８", "９"]

$Lchinesenum = Set.new ["〇", "零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "百", "千", "万"]

$Lallnum = $Larabnum + $Lchinesenum

$Lromaji = Set.new ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "ａ", "ｂ", "ｃ", "ｄ", "ｅ", "ｆ", "ｇ", "ｈ", "ｉ", "ｊ", "ｋ", "ｌ", "ｍ", "ｎ", "ｏ", "ｐ", "ｑ", "ｒ", "ｓ", "ｔ", "ｕ", "ｖ", "ｗ", "ｘ", "ｙ", "ｚ", "Ａ", "Ｂ", "Ｃ", "Ｄ", "Ｅ", "Ｆ", "Ｇ", "Ｈ", "Ｉ", "Ｊ", "Ｋ", "Ｌ", "Ｍ", "Ｎ", "Ｏ", "Ｐ", "Ｑ", "Ｒ", "Ｓ", "Ｔ", "Ｕ", "Ｖ", "Ｗ", "Ｘ", "Ｙ", "Ｚ"]

$Lhiragana = Set.new ["ぁ", "あ", "ぃ", "い", "ぅ", "う", "ぇ", "え", "ぉ", "お", "か", "が", "き", "ぎ", "く ぐ", "け", "げ", "こ", "ご", "さ", "ざ", "し", "じ", "す", "ず", "せ", "ぜ", "そ", "ぞ", "た だ", "ち", "ぢ", "っ", "つ", "づ", "て で", "と", "ど", "な", "に", "ぬ", "ね", "の", "は ば", "ぱ", "ひ", "び", "ぴ", "ふ", "ぶ", "ぷ", "へ", "べ", "ぺ", "ほ", "ぼ", "ぽ", "ま", "み む", "め", "も", "ゃ", "や", "ゅ", "ゆ", "ょ", "よ", "ら", "り", "る", "れ", "ろ", "ゎ", "わ ゐ", "ゑ", "を", "ん", "ゔ", "ゕ", "ゖ", "ゝ", "ゞ", "ゟ"]

$Lkatakana = Set.new ["ア", "ァ", "カ", "ヵ", "ガ", "サ", "ザ", "タ", "ダ", "ナ", "ハ", "ㇵ", "バ", "パ", "マ", "ヤ", "ャ", "ラ", "ㇻ", "ワ", "ヮ", "ヷ", "ン", "イ", "ィ", "キ", "ギ", "シ", "ㇱ", "ジ", "チ", "ヂ", "ニ", "ヒ", "ㇶ", "ビ", "ピ", "ミ", "リ", "ㇼ", "ヰ", "ウ", "ゥ", "ヴ", "ク", "ㇰ", "グ", "ス", "ㇲ", "ズ", "ツ", "ッ", "ヅ", "ヌ", "ㇴ", "フ", "ㇷ", "ブ", "プ", "ム", "ㇺ", "ユ", "ュ", "ル", "ㇽ", "エ" ,"ェ", "ケ", "ヶ" ,"ゲ", "セ", "ゼ", "テ", "デ", "ネ", "ヘ", "ㇸ", "ベ", "ペ", "メ", "レ", "ㇾ", "ヱ", "オ", "ォ", "コ", "ゴ", "ソ", "ゾ", "ト", "ㇳ", "ド", "ノ", "ホ", "ㇹ", "ボ", "ポ", "モ", "ヨ", "ョ", "ロ", "ㇿ", "ヲ"]

$LposMapping = {"名詞" => "Noun", "動詞" => "Verb", "形容詞" => "Adjective", "指示詞" => "Demonstrative", "助動詞" => "Auxiliary", "連体詞" => "PreNounAdjectival", "接尾辞" => "Suffix", "副詞" => "Adverb", "助詞" => "Particle", "判定詞" => "Decision", "接続詞" => "Conjunction", "特殊" => "Special", "接頭辞" => "Prefix", "感動詞" => "Interjection", "未定義語" => "Undefined"}

$LpartsOfSpeech = $LposMapping.values
$LpartsOfSpeech.delete("Adjective")
$LpartsOfSpeech.push("IAdjective")
$LpartsOfSpeech.push("NaAdjective")
$LpartsOfSpeech.push("TaruAdjective")

def posMapping
	return $LposMapping
end

def partsOfSpeech
	return $LpartsOfSpeech
end

def punctuation
	return $Lpunctuation
end

def allnum
	return $Lallnum
end

def arabnum
	return $Larabnum
end

def romaji
	return $Lromaji
end

def hiragana
	return $Lhiragana
end

def katakana
	return $Lkatakana
end
