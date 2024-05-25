import Hashmap "mo:base/HashMap";
import List "mo:base/List";
import Array "mo:base/Array";
import Text "mo:base/Text";
import Random "mo:base/Random";

actor LagaLuga {

  let map = Hashmap.HashMap<Text, Text>(0, Text.equal, Text.hash);

  public func getWords(x : Text, y : Text) : async () {
    map.put(x, y);
  };

  public func Question() : async ?Text {
    if (map.size() != 0) {
      for ((key, value) in map.entries()) {
        return ?key;
      };
      return ?("Eklenen kelimelerde eksik var!");
    } else {
      return ?("Hiç kelime eklenmedi");
    };
  };

  public func Answer(answr : Text) : async Bool {
    for ((key, value) in map.entries()) {
      if (answr == value) {
        map.remove(key);
        return true;
      } else {
        return false;
      };
    };
    return false;
  };
};
