import Text "mo:base/Text";
import List "mo:base/List";
import Random "mo:base/Random";
import Nat8 "mo:base/Nat8";

// Bilmediğiniz ve yeni öğrendiğiniz ingilizce kelimeleri ve onların türkçe karşılıklarını yazarak kaydettiğiniz bu sistemde zamanla biriken ingilizce kelimelerden kendinizi sınayıp o kelimeleri gerçekten öğrenip öğrenmediğinizi test edebilirsiniz.
// getWords fonksiyonunun aldığı argümanlar sırasıyla ingilizce ve türkçe kelimedir.
// getWords fonksiyonuna sırasıyla ingilizce ve türkçe kelimeleri girebilir ve fonksiyonu CALL ederek bunu kaydedebilirsiniz.
// Kendinizi yeterli hissettiğinizde Question fonksiyonunu CALL ederek karşınıza çıkan ingilizce kelimenin karşılığını Answer fonksiyonu içine yazıp CALL edebilir ve doğru mu yanlış mı olduğunu görebilirsiniz.

actor LagaLuga {

  stable var enWords = List.nil<Text>();
  stable var trWords = List.nil<Text>();
  stable var random : Nat = 0;

  public func getWords(x : Text, y : Text) : async () {
    enWords := List.push(x, enWords);
    trWords := List.push(y, trWords);
  };

  public func Question() : async ?Text {
    let entropy = await Random.blob();
    let enWordsSize : Nat = List.size<Text>(enWords);
    if (enWordsSize != 0) {
      random := Nat8.toNat(Random.byteFrom(entropy)) % enWordsSize;
      let getRandomWord : ?Text = List.get(enWords, random);
      return getRandomWord;
    } else {
      return ?("Hiç kelime eklenmedi!");
    };
  };

  public func Answer(answer : Text) : async ?Bool {
    let trWordsSize : Nat = List.size<Text>(trWords);
    if (trWordsSize != 0) {
      let setRandomWord : ?Text = List.get(trWords, random);
      if (?answer == setRandomWord) {
        return ?true;
      } else {
        return ?false;
      };
    } else {
      return null;
    };
  };
};
