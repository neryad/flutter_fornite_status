// To parse this JSON data, do
//
//     final main = mainFromJson(jsonString);

import 'dart:convert';

Main mainFromJson(String str) => Main.fromJson(json.decode(str));

String mainToJson(Main data) => json.encode(data.toJson());

class Main {
  int? status;
  Data? data;

  Main({
    this.status,
    this.data,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  String? hash;
  DateTime? date;
  String? vbuckIcon;
  List<Entry>? entries;

  Data({
    this.hash,
    this.date,
    this.vbuckIcon,
    this.entries,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    // print("Parsing Data: ${json}"); // Imprime todo el JSON de `Data`
    return Data(
      hash: json["hash"],
      date: json["date"] == null ? null : DateTime.parse(json["date"]),
      vbuckIcon: json["vbuckIcon"],
      entries: json["entries"] == null
          ? []
          : List<Entry>.from(json["entries"]!.map((x) {
              // print(
              //     "Parsing Entry: $x"); // Imprime cada entrada antes de procesarla
              return Entry.fromJson(x); // Procesa cada entrada
            })),
    );
  }

  Map<String, dynamic> toJson() => {
        "hash": hash,
        "date": date?.toIso8601String(),
        "vbuckIcon": vbuckIcon,
        "entries": entries == null
            ? []
            : List<dynamic>.from(entries!.map((x) => x.toJson())),
      };
}

class Entry {
  int? regularPrice;
  int? finalPrice;
  String? devName;
  String? offerId;
  DateTime? inDate;
  DateTime? outDate;
  OfferTag? offerTag;
  bool? giftable;
  bool? refundable;
  int? sortPriority;
  String? layoutId;
  Layout? layout;
  TileSize? tileSize;
  String? newDisplayAssetPath;
  List<Track>? tracks;
  EntryColors? colors;
  NewDisplayAsset? newDisplayAsset;
  List<BrItem>? brItems;
  String? displayAssetPath;
  Bundle? bundle;
  Banner? banner;
  List<Car>? cars;
  List<Car>? instruments;

  Entry({
    this.regularPrice,
    this.finalPrice,
    this.devName,
    this.offerId,
    this.inDate,
    this.outDate,
    this.offerTag,
    this.giftable,
    this.refundable,
    this.sortPriority,
    this.layoutId,
    this.layout,
    this.tileSize,
    this.newDisplayAssetPath,
    this.tracks,
    this.colors,
    this.newDisplayAsset,
    this.brItems,
    this.displayAssetPath,
    this.bundle,
    this.banner,
    this.cars,
    this.instruments,
  });

  factory Entry.fromJson(Map<String, dynamic> json) {
    //print("Processing Entry: $json"); // Imprime el JSON de cada entrada

    try {
      return Entry(
        regularPrice: json["regularPrice"] ??
            0.0, // Aseguramos un valor por defecto para regularPrice si es null
        finalPrice: json["finalPrice"] ?? 0, // Manejo seguro de `null`
        devName:
            json["devName"] ?? "Unknown", // Valor predeterminado si está vacío
        offerId: json["offerId"] ?? "",
        inDate: json["inDate"] == null
            ? null
            : DateTime.tryParse(json[
                "inDate"]), // Uso de tryParse para evitar errores si el formato de la fecha no es válido
        outDate:
            json["outDate"] == null ? null : DateTime.tryParse(json["outDate"]),
        offerTag: json["offerTag"] == null
            ? null
            : OfferTag.fromJson(json["offerTag"]), // Manejo seguro
        giftable: json["giftable"] ?? false,
        refundable: json["refundable"] ?? false,
        sortPriority: json["sortPriority"] ?? 0,
        layoutId: json["layoutId"] ?? "",
        layout: json["layout"] == null ? null : Layout.fromJson(json["layout"]),
        tileSize: json["tileSize"] != null
            ? tileSizeValues.map[json["tileSize"]] ?? TileSize.SIZE_1_X_1
            : TileSize.SIZE_1_X_1,
        newDisplayAssetPath: json["newDisplayAssetPath"] ?? "",
        tracks: json["tracks"] == null
            ? [] // Si "tracks" es null, lo asignamos como una lista vacía
            : List<Track>.from(json["tracks"]!.map((x) => Track.fromJson(x))),
        brItems: json["brItems"] == null
            ? [] // Si "brItems" es null, lo asignamos como una lista vacía
            : List<BrItem>.from(
                json["brItems"]!.map((x) => BrItem.fromJson(x))),
      );
    } catch (e) {
      print("Error processing Entry: $e");
      throw Exception("Failed to parse Entry: $e");
    }
  }

//??Buena
  // factory Entry.fromJson(Map<String, dynamic> json) {
  //   print("Processing Entry: $json"); // Imprime el JSON de cada entrada

  //   try {
  //     return Entry(
  //       regularPrice: json["regularPrice"],
  //       finalPrice: json["finalPrice"] ?? 0, // Manejo seguro de `null`
  //       devName:
  //           json["devName"] ?? "Unknown", // Valor predeterminado si está vacío
  //       offerId: json["offerId"] ?? "",
  //       inDate: json["inDate"] == null ? null : DateTime.parse(json["inDate"]),
  //       outDate:
  //           json["outDate"] == null ? null : DateTime.parse(json["outDate"]),
  //       offerTag: json["offerTag"] == null
  //           ? null
  //           : OfferTag.fromJson(json["offerTag"]), // Manejo seguro
  //       giftable: json["giftable"] ?? false,
  //       refundable: json["refundable"] ?? false,
  //       sortPriority: json["sortPriority"] ?? 0,
  //       layoutId: json["layoutId"] ??
  //           "", // Si el valor no es compatible, usa predeterminado
  //       layout: json["layout"] == null ? null : Layout.fromJson(json["layout"]),
  //       tileSize: json["tileSize"] != null
  //           ? tileSizeValues.map[json["tileSize"]] ?? TileSize.SIZE_1_X_1
  //           : TileSize.SIZE_1_X_1,
  //       newDisplayAssetPath: json["newDisplayAssetPath"] ?? "",
  //       tracks: json["tracks"] == null
  //           ? []
  //           : List<Track>.from(json["tracks"]!.map((x) => Track.fromJson(x))),
  //       brItems: json["brItems"] == null
  //           ? []
  //           : List<BrItem>.from(
  //               json["brItems"]!.map((x) => BrItem.fromJson(x))),
  //     );
  //   } catch (e) {
  //     print("Error processing Entry: $e");
  //     throw Exception("Failed to parse Entry: $e");
  //   }
  // }

  // factory Entry.fromJson(Map<String, dynamic> json) => Entry(
  //       regularPrice: json["regularPrice"],
  //       finalPrice: json["finalPrice"],
  //       devName: json["devName"],
  //       offerId: json["offerId"],
  //       inDate: json["inDate"] == null ? null : DateTime.parse(json["inDate"]),
  //       outDate:
  //           json["outDate"] == null ? null : DateTime.parse(json["outDate"]),
  //       offerTag: json["offerTag"] == null
  //           ? null
  //           : OfferTag.fromJson(json["offerTag"]),
  //       giftable: json["giftable"],
  //       refundable: json["refundable"],
  //       sortPriority: json["sortPriority"],
  //       layoutId: json["layoutId"],
  //       layout: json["layout"] == null ? null : Layout.fromJson(json["layout"]),
  //       // tileSize: [json["tileSize"]]!,
  //       newDisplayAssetPath: json["newDisplayAssetPath"],
  //       tracks: json["tracks"] == null
  //           ? []
  //           : List<Track>.from(json["tracks"]!.map((x) => Track.fromJson(x))),
  //       colors: json["colors"] == null
  //           ? null
  //           : EntryColors.fromJson(json["colors"]),
  //       newDisplayAsset: json["newDisplayAsset"] == null
  //           ? null
  //           : NewDisplayAsset.fromJson(json["newDisplayAsset"]),
  //       brItems: json["brItems"] == null
  //           ? []
  //           : List<BrItem>.from(
  //               json["brItems"]!.map((x) => BrItem.fromJson(x))),
  //       displayAssetPath: json["displayAssetPath"],
  //       bundle: json["bundle"] == null ? null : Bundle.fromJson(json["bundle"]),
  //       banner: json["banner"] == null ? null : Banner.fromJson(json["banner"]),
  //       cars: json["cars"] == null
  //           ? []
  //           : List<Car>.from(json["cars"]!.map((x) => Car.fromJson(x))),
  //       instruments: json["instruments"] == null
  //           ? []
  //           : List<Car>.from(json["instruments"]!.map((x) => Car.fromJson(x))),
  //     );

  Map<String, dynamic> toJson() => {
        "regularPrice": regularPrice,
        "finalPrice": finalPrice,
        "devName": devName,
        "offerId": offerId,
        "inDate": inDate?.toIso8601String(),
        "outDate": outDate?.toIso8601String(),
        "offerTag": offerTag?.toJson(),
        "giftable": giftable,
        "refundable": refundable,
        "sortPriority": sortPriority,
        "layoutId": layoutId,
        "layout": layout?.toJson(),
        "tileSize": tileSizeValues.reverse[tileSize],
        "newDisplayAssetPath": newDisplayAssetPath,
        "tracks": tracks == null
            ? []
            : List<dynamic>.from(tracks!.map((x) => x.toJson())),
        "colors": colors?.toJson(),
        "newDisplayAsset": newDisplayAsset?.toJson(),
        "brItems": brItems == null
            ? []
            : List<dynamic>.from(brItems!.map((x) => x.toJson())),
        "displayAssetPath": displayAssetPath,
        "bundle": bundle?.toJson(),
        "banner": banner?.toJson(),
        "cars": cars == null
            ? []
            : List<dynamic>.from(cars!.map((x) => x.toJson())),
        "instruments": instruments == null
            ? []
            : List<dynamic>.from(instruments!.map((x) => x.toJson())),
      };
}

class Banner {
  String? value;
  Intensity? intensity;
  String? backendValue;

  Banner({
    this.value,
    this.intensity,
    this.backendValue,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        value: json["value"],
        intensity: intensityValues.map[json["intensity"]]!,
        backendValue: json["backendValue"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "intensity": intensityValues.reverse[intensity],
        "backendValue": backendValue,
      };
}

enum Intensity { HIGH, LOW }

final intensityValues =
    EnumValues({"High": Intensity.HIGH, "Low": Intensity.LOW});

class BrItem {
  String? id;
  String? name;
  String? description;
  Rarity? type;
  Rarity? rarity;
  Introduction? introduction;
  BrItemImages? images;
  String? showcaseVideo;
  DateTime? added;
  Series? series;
  Set? brItemSet;
  List<Variant>? variants;
  List<String>? metaTags;
  List<String>? builtInEmoteIds;
  String? dynamicPakId;

  BrItem({
    this.id,
    this.name,
    this.description,
    this.type,
    this.rarity,
    this.introduction,
    this.images,
    this.showcaseVideo,
    this.added,
    this.series,
    this.brItemSet,
    this.variants,
    this.metaTags,
    this.builtInEmoteIds,
    this.dynamicPakId,
  });

  //aqui

  factory BrItem.fromJson(Map<String, dynamic> json) {
    try {
      print("Parsing BrItem: $json");

      // Imprime cada campo para identificar el problema
      // print("id: ${json['id']}");
      // print("name: ${json['name']}");
      // print("description: ${json['description']}");
      // print("type: ${json['type']}");
      // print("rarity: ${json['rarity']}");
      // print("introduction: ${json['introduction']}");
      // print("images: ${json['images']}");
      // print("showcaseVideo: ${json['showcaseVideo']}");
      // print("added: ${json['added']}");
      // print("series: ${json['series']}");
      // print("set: ${json['set']}");
      // print("variants: ${json['variants']}");
      // print("metaTags: ${json['metaTags']}");
      // print("builtInEmoteIds: ${json['builtInEmoteIds']}");
      // print("dynamicPakId: ${json['dynamicPakId']}");

      return BrItem(
        id: json["id"] ?? "", // Valor por defecto si "id" es nulo
        name: json["name"] ??
            "Unknown Item", // Valor por defecto si "name" es nulo
        description: json["description"] ??
            "No description available", // Valor por defecto si "description" es nulo
        type: json["type"] != null && json["type"] is Map
            ? Rarity.fromJson(json["type"])
            : Rarity(), // Si "type" es nulo o no es un Map, asigna un Rarity vacío
        rarity: json["rarity"] != null && json["rarity"] is Map
            ? Rarity.fromJson(json["rarity"])
            : Rarity(), // Lo mismo para "rarity"
        introduction: json["introduction"] != null &&
                json["introduction"] is Map
            ? Introduction.fromJson(json["introduction"])
            : Introduction(), // Si "introduction" es nulo o no es un Map, asigna un Introduction vacío
        images: json["images"] != null && json["images"] is Map
            ? BrItemImages.fromJson(json["images"])
            : BrItemImages(), // Lo mismo para "images"
        showcaseVideo: json["showcaseVideo"] ??
            "", // Si "showcaseVideo" es nulo, asigna cadena vacía
        added: json["added"] == null
            ? DateTime.now() // Si "added" es nulo, asigna la fecha actual
            : DateTime.tryParse(json["added"]) ??
                DateTime
                    .now(), // Si la fecha no es válida, asigna la fecha actual
        series: json["series"] != null && json["series"] is Map
            ? Series.fromJson(json["series"])
            : Series(), // Lo mismo para "series"
        // brItemSet: json["set"] != null && json["set"] is Map
        //     ? Set.fromJson(json["set"])
        //     : Set(), // Lo mismo para "set"
        // variants: json["variants"] != null && json["variants"] is List
        //     ? List<Variant>.from(
        //         json["variants"]!.map((x) => Variant.fromJson(x)))
        //     : [], // Si "variants" es nulo o no es una lista, asigna una lista vacía
        // metaTags: json["metaTags"] != null && json["metaTags"] is List
        //     ? List<String>.from(json["metaTags"]!.map((x) => x))
        //     : [], // Lo mismo para metaTags
        // builtInEmoteIds:
        //     json["builtInEmoteIds"] != null && json["builtInEmoteIds"] is List
        //         ? List<String>.from(json["builtInEmoteIds"]!.map((x) => x))
        //         : [], // Lo mismo para builtInEmoteIds
        // dynamicPakId: json["dynamicPakId"] ??
        //     "", // Si es nulo o vacío, asigna cadena vacía
      );
    } catch (e) {
      print("Error parsing BrItem: $e");
      throw Exception("Failed to parse BrItem: $e");
    }
  }
  // factory BrItem.fromJson(Map<String, dynamic> json) {
  //   try {
  //     print("Parsing BrItem: $json");

  //     // Imprime cada campo para identificar el problema
  //     print("id: ${json['id']}");
  //     print("name: ${json['name']}");
  //     print("description: ${json['description']}");
  //     print("type: ${json['type']}");
  //     print("rarity: ${json['rarity']}");
  //     print("introduction: ${json['introduction']}");
  //     print("images: ${json['images']}");
  //     print("showcaseVideo: ${json['showcaseVideo']}");
  //     print("added: ${json['added']}");
  //     print("series: ${json['series']}");
  //     print("set: ${json['set']}");
  //     print("variants: ${json['variants']}");
  //     print("metaTags: ${json['metaTags']}");
  //     print("builtInEmoteIds: ${json['builtInEmoteIds']}");
  //     print("dynamicPakId: ${json['dynamicPakId']}");

  //     return BrItem(
  //       id: json["id"] ?? "",
  //       name: json["name"] ?? "Unknown Item",
  //       description: json["description"] ?? "No description available",
  //       type: json["type"] == null ? null : Rarity.fromJson(json["type"]),
  //       rarity: json["rarity"] == null ? null : Rarity.fromJson(json["rarity"]),
  //       introduction: json["introduction"] == null
  //           ? null
  //           : Introduction.fromJson(json["introduction"]),
  //       images: json["images"] == null
  //           ? null
  //           : BrItemImages.fromJson(json["images"]),
  //       showcaseVideo: json["showcaseVideo"] ?? "",
  //       added: json["added"] == null
  //           ? null
  //           : DateTime.tryParse(json["added"]) ?? null,
  //       series: json["series"] == null ? null : Series.fromJson(json["series"]),
  //       brItemSet: json["set"] == null ? null : Set.fromJson(json["set"]),
  //       variants: (json["variants"] is List)
  //           ? List<Variant>.from(
  //               json["variants"]!.map((x) => Variant.fromJson(x)))
  //           : [], // Si "variants" es null o no es una lista, asignamos una lista vacía
  //       metaTags: (json["metaTags"] is List)
  //           ? List<String>.from(json["metaTags"]!.map((x) => x))
  //           : [], // Lo mismo para metaTags
  //       builtInEmoteIds: (json["builtInEmoteIds"] is List)
  //           ? List<String>.from(json["builtInEmoteIds"]!.map((x) => x))
  //           : [], // Lo mismo para builtInEmoteIds
  //       dynamicPakId: json["dynamicPakId"] ??
  //           "", // Si es null o vacío, asignamos cadena vacía
  //     );
  //   } catch (e) {
  //     print("Error parsing BrItem: $e");
  //     throw Exception("Failed to parse BrItem: $e");
  //   }
  // }

  // factory BrItem.fromJson(Map<String, dynamic> json) {
  //   try {
  //     print("Parsing BrItem: $json");

  //     // Imprime cada campo para identificar el problema
  //     print("id: ${json['id']}");
  //     print("name: ${json['name']}");
  //     print("description: ${json['description']}");
  //     print("type: ${json['type']}");
  //     print("rarity: ${json['rarity']}");
  //     print("introduction: ${json['introduction']}");
  //     print("images: ${json['images']}");
  //     print("showcaseVideo: ${json['showcaseVideo']}");
  //     print("added: ${json['added']}");
  //     print("series: ${json['series']}");
  //     print("set: ${json['set']}");
  //     print("variants: ${json['variants']}");
  //     print("metaTags: ${json['metaTags']}");
  //     print("builtInEmoteIds: ${json['builtInEmoteIds']}");
  //     print("dynamicPakId: ${json['dynamicPakId']}");

  //     return BrItem(
  //       id: json["id"] ?? "",
  //       name: json["name"] ?? "Unknown Item",
  //       description: json["description"] ?? "No description available",
  //       type: json["type"] == null ? null : Rarity.fromJson(json["type"]),
  //       rarity: json["rarity"] == null ? null : Rarity.fromJson(json["rarity"]),
  //       introduction: json["introduction"] == null
  //           ? null
  //           : Introduction.fromJson(json["introduction"]),
  //       images: json["images"] == null
  //           ? null
  //           : BrItemImages.fromJson(json["images"]),
  //       showcaseVideo: json["showcaseVideo"] ?? "",
  //       added: json["added"] == null
  //           ? null
  //           : DateTime.tryParse(json["added"]) ?? null,
  //       series: json["series"] == null ? null : Series.fromJson(json["series"]),
  //       brItemSet: json["set"] == null ? null : Set.fromJson(json["set"]),
  //       variants: json["variants"] == null
  //           ? []
  //           : List<Variant>.from(
  //               json["variants"]!.map((x) => Variant.fromJson(x))),
  //       metaTags: json["metaTags"] == null
  //           ? []
  //           : List<String>.from(json["metaTags"]!.map((x) => x)),
  //       builtInEmoteIds: json["builtInEmoteIds"] == null
  //           ? []
  //           : List<String>.from(json["builtInEmoteIds"]!.map((x) => x)),
  //       dynamicPakId: json["dynamicPakId"] ?? "",
  //     );
  //   } catch (e) {
  //     print("Error parsing BrItem: $e");
  //     throw Exception("Failed to parse BrItem: $e");
  //   }
  // }

  // factory BrItem.fromJson(Map<String, dynamic> json) {
  //   print("Parsing BrItem: $json"); // Depuración del JSON de entrada

  //   try {
  //     return BrItem(
  //       id: json["id"] ?? "", // Valor predeterminado si `id` es nulo
  //       name: json["name"] ?? "Unknown Item", // Nombre predeterminado
  //       description:
  //           json["description"] ?? "No description available", // Manejo seguro
  //       type: json["type"] == null
  //           ? null
  //           : Rarity.fromJson(json["type"]), // Manejo seguro para tipos
  //       rarity: json["rarity"] == null
  //           ? null
  //           : Rarity.fromJson(json["rarity"]), // Manejo seguro para rarezas
  //       introduction: json["introduction"] == null
  //           ? null
  //           : Introduction.fromJson(json["introduction"]), // Manejo seguro
  //       images: json["images"] == null
  //           ? null
  //           : BrItemImages.fromJson(
  //               json["images"]), // Manejo seguro de imágenes
  //       showcaseVideo: json["showcaseVideo"] ?? "", // Valor predeterminado
  //       added: json["added"] == null
  //           ? null
  //           : DateTime.tryParse(json["added"]) ??
  //               null, // Manejo seguro de fechas
  //       series: json["series"] == null
  //           ? null
  //           : Series.fromJson(json["series"]), // Manejo seguro para series
  //       brItemSet: json["set"] == null
  //           ? null
  //           : Set.fromJson(json["set"]), // Manejo seguro para conjuntos
  //       variants: json["variants"] == null
  //           ? [] // Lista vacía si no hay variantes
  //           : List<Variant>.from(
  //               json["variants"]!.map((x) => Variant.fromJson(x))),
  //       metaTags: json["metaTags"] == null
  //           ? [] // Lista vacía si no hay meta etiquetas
  //           : List<String>.from(json["metaTags"]!.map((x) => x)),
  //       builtInEmoteIds: json["builtInEmoteIds"] == null
  //           ? [] // Lista vacía si no hay emotes integrados
  //           : List<String>.from(json["builtInEmoteIds"]!.map((x) => x)),
  //       dynamicPakId: json["dynamicPakId"] ?? "", // Manejo seguro del ID
  //     );
  //   } catch (e) {
  //     print("Error parsing BrItem: $e"); // Depuración en caso de error
  //     throw Exception("Failed to parse BrItem: $e");
  //   }
  // }

  // factory BrItem.fromJson(Map<String, dynamic> json) => BrItem(
  //       id: json["id"],
  //       name: json["name"],
  //       description: json["description"],
  //       type: json["type"] == null ? null : Rarity.fromJson(json["type"]),
  //       rarity: json["rarity"] == null ? null : Rarity.fromJson(json["rarity"]),
  //       introduction: json["introduction"] == null
  //           ? null
  //           : Introduction.fromJson(json["introduction"]),
  //       images: json["images"] == null
  //           ? null
  //           : BrItemImages.fromJson(json["images"]),
  //       showcaseVideo: json["showcaseVideo"],
  //       added: json["added"] == null ? null : DateTime.parse(json["added"]),
  //       series: json["series"] == null ? null : Series.fromJson(json["series"]),
  //       brItemSet: json["set"] == null ? null : Set.fromJson(json["set"]),
  //       variants: json["variants"] == null
  //           ? []
  //           : List<Variant>.from(
  //               json["variants"]!.map((x) => Variant.fromJson(x))),
  //       metaTags: json["metaTags"] == null
  //           ? []
  //           : List<String>.from(json["metaTags"]!.map((x) => x)),
  //       builtInEmoteIds: json["builtInEmoteIds"] == null
  //           ? []
  //           : List<String>.from(json["builtInEmoteIds"]!.map((x) => x)),
  //       dynamicPakId: json["dynamicPakId"],
  //     );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type?.toJson(),
        "rarity": rarity?.toJson(),
        "introduction": introduction?.toJson(),
        "images": images?.toJson(),
        "showcaseVideo": showcaseVideo,
        "added": added?.toIso8601String(),
        "series": series?.toJson(),
        "set": brItemSet?.toJson(),
        "variants": variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "metaTags":
            metaTags == null ? [] : List<dynamic>.from(metaTags!.map((x) => x)),
        "builtInEmoteIds": builtInEmoteIds == null
            ? []
            : List<dynamic>.from(builtInEmoteIds!.map((x) => x)),
        "dynamicPakId": dynamicPakId,
      };
}

class Set {
  String? value;
  String? text;
  String? backendValue;

  Set({
    this.value,
    this.text,
    this.backendValue,
  });

  factory Set.fromJson(Map<String, dynamic> json) => Set(
        value: json["value"],
        text: json["text"],
        backendValue: json["backendValue"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "text": text,
        "backendValue": backendValue,
      };
}

class BrItemImages {
  String? smallIcon;
  String? icon;
  String? featured;
  BeanClass? lego;
  BeanClass? bean;
  Other? other;

  BrItemImages({
    this.smallIcon,
    this.icon,
    this.featured,
    this.lego,
    this.bean,
    this.other,
  });

  factory BrItemImages.fromJson(Map<String, dynamic> json) => BrItemImages(
        smallIcon: json["smallIcon"],
        icon: json["icon"],
        featured: json["featured"],
        lego: json["lego"] == null ? null : BeanClass.fromJson(json["lego"]),
        bean: json["bean"] == null ? null : BeanClass.fromJson(json["bean"]),
        other: json["other"] == null ? null : Other.fromJson(json["other"]),
      );

  Map<String, dynamic> toJson() => {
        "smallIcon": smallIcon,
        "icon": icon,
        "featured": featured,
        "lego": lego?.toJson(),
        "bean": bean?.toJson(),
        "other": other?.toJson(),
      };
}

class BeanClass {
  String? small;
  String? large;

  BeanClass({
    this.small,
    this.large,
  });

  factory BeanClass.fromJson(Map<String, dynamic> json) => BeanClass(
        small: json["small"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "small": small,
        "large": large,
      };
}

class Other {
  String? coverart;
  String? background;

  Other({
    this.coverart,
    this.background,
  });

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        coverart: json["coverart"],
        background: json["background"],
      );

  Map<String, dynamic> toJson() => {
        "coverart": coverart,
        "background": background,
      };
}

class Introduction {
  String? chapter;
  String? season;
  String? text;
  int? backendValue;

  Introduction({
    this.chapter,
    this.season,
    this.text,
    this.backendValue,
  });

  factory Introduction.fromJson(Map<String, dynamic> json) => Introduction(
        chapter: json["chapter"],
        season: json["season"],
        text: json["text"],
        backendValue: json["backendValue"],
      );

  Map<String, dynamic> toJson() => {
        "chapter": chapter,
        "season": season,
        "text": text,
        "backendValue": backendValue,
      };
}

class Rarity {
  PurpleValue? value;
  DisplayValueEnum? displayValue;
  RarityBackendValue? backendValue;

  Rarity({
    this.value,
    this.displayValue,
    this.backendValue,
  });

  factory Rarity.fromJson(Map<String, dynamic> json) => Rarity(
        value: purpleValueValues.map[json["value"]]!,
        displayValue: displayValueEnumValues.map[json["displayValue"]]!,
        backendValue: rarityBackendValueValues.map[json["backendValue"]]!,
      );

  Map<String, dynamic> toJson() => {
        "value": purpleValueValues.reverse[value],
        "displayValue": displayValueEnumValues.reverse[displayValue],
        "backendValue": rarityBackendValueValues.reverse[backendValue],
      };
}

enum RarityBackendValue {
  ATHENA_BACKPACK,
  ATHENA_CHARACTER,
  ATHENA_DANCE,
  ATHENA_GLIDER,
  ATHENA_ITEM_WRAP,
  ATHENA_LOADING_SCREEN,
  ATHENA_MUSIC_PACK,
  ATHENA_PICKAXE,
  COSMETIC_SHOES,
  E_FORT_RARITY_COMMON,
  E_FORT_RARITY_EPIC,
  E_FORT_RARITY_LEGENDARY,
  E_FORT_RARITY_RARE,
  E_FORT_RARITY_UNCOMMON,
  SPARKS_DRUM,
  SPARKS_MIC,
  VEHICLE_COSMETICS_BODY,
  VEHICLE_COSMETICS_BOOSTER,
  VEHICLE_COSMETICS_SKIN,
  VEHICLE_COSMETICS_WHEEL
}

final rarityBackendValueValues = EnumValues({
  "AthenaBackpack": RarityBackendValue.ATHENA_BACKPACK,
  "AthenaCharacter": RarityBackendValue.ATHENA_CHARACTER,
  "AthenaDance": RarityBackendValue.ATHENA_DANCE,
  "AthenaGlider": RarityBackendValue.ATHENA_GLIDER,
  "AthenaItemWrap": RarityBackendValue.ATHENA_ITEM_WRAP,
  "AthenaLoadingScreen": RarityBackendValue.ATHENA_LOADING_SCREEN,
  "AthenaMusicPack": RarityBackendValue.ATHENA_MUSIC_PACK,
  "AthenaPickaxe": RarityBackendValue.ATHENA_PICKAXE,
  "CosmeticShoes": RarityBackendValue.COSMETIC_SHOES,
  "EFortRarity::Common": RarityBackendValue.E_FORT_RARITY_COMMON,
  "EFortRarity::Epic": RarityBackendValue.E_FORT_RARITY_EPIC,
  "EFortRarity::Legendary": RarityBackendValue.E_FORT_RARITY_LEGENDARY,
  "EFortRarity::Rare": RarityBackendValue.E_FORT_RARITY_RARE,
  "EFortRarity::Uncommon": RarityBackendValue.E_FORT_RARITY_UNCOMMON,
  "SparksDrum": RarityBackendValue.SPARKS_DRUM,
  "SparksMic": RarityBackendValue.SPARKS_MIC,
  "VehicleCosmetics_Body": RarityBackendValue.VEHICLE_COSMETICS_BODY,
  "VehicleCosmetics_Booster": RarityBackendValue.VEHICLE_COSMETICS_BOOSTER,
  "VehicleCosmetics_Skin": RarityBackendValue.VEHICLE_COSMETICS_SKIN,
  "VehicleCosmetics_Wheel": RarityBackendValue.VEHICLE_COSMETICS_WHEEL
});

enum DisplayValueEnum {
  BACK_BLING,
  BODY,
  COMMON,
  DRUMS,
  EMOTE,
  EPIC,
  GAMING_LEGENDS_SERIES,
  GLIDER,
  ICON_SERIES,
  LEGENDARY,
  LOADING_SCREEN,
  LOBBY_MUSIC,
  MICROPHONE,
  OUTFIT,
  PICKAXE,
  RARE,
  SHOES,
  SKIN,
  TURBO,
  UNCOMMON,
  WHEEL,
  WRAP
}

final displayValueEnumValues = EnumValues({
  "Back Bling": DisplayValueEnum.BACK_BLING,
  "Body": DisplayValueEnum.BODY,
  "Common": DisplayValueEnum.COMMON,
  "Drums": DisplayValueEnum.DRUMS,
  "Emote": DisplayValueEnum.EMOTE,
  "Epic": DisplayValueEnum.EPIC,
  "Gaming Legends Series": DisplayValueEnum.GAMING_LEGENDS_SERIES,
  "Glider": DisplayValueEnum.GLIDER,
  "Icon Series": DisplayValueEnum.ICON_SERIES,
  "Legendary": DisplayValueEnum.LEGENDARY,
  "Loading Screen": DisplayValueEnum.LOADING_SCREEN,
  "Lobby Music": DisplayValueEnum.LOBBY_MUSIC,
  "Microphone": DisplayValueEnum.MICROPHONE,
  "Outfit": DisplayValueEnum.OUTFIT,
  "Pickaxe": DisplayValueEnum.PICKAXE,
  "Rare": DisplayValueEnum.RARE,
  "Shoes": DisplayValueEnum.SHOES,
  "Skin": DisplayValueEnum.SKIN,
  "Turbo": DisplayValueEnum.TURBO,
  "Uncommon": DisplayValueEnum.UNCOMMON,
  "Wheel": DisplayValueEnum.WHEEL,
  "Wrap": DisplayValueEnum.WRAP
});

enum PurpleValue {
  BACKPACK,
  BODY,
  BOOSTER,
  COMMON,
  DRUM,
  EMOTE,
  EPIC,
  GAMINGLEGENDS,
  GLIDER,
  ICON,
  LEGENDARY,
  LOADINGSCREEN,
  MIC,
  MUSIC,
  OUTFIT,
  PICKAXE,
  RARE,
  SHOE,
  SKIN,
  UNCOMMON,
  WHEEL,
  WRAP
}

final purpleValueValues = EnumValues({
  "backpack": PurpleValue.BACKPACK,
  "body": PurpleValue.BODY,
  "booster": PurpleValue.BOOSTER,
  "common": PurpleValue.COMMON,
  "drum": PurpleValue.DRUM,
  "emote": PurpleValue.EMOTE,
  "epic": PurpleValue.EPIC,
  "gaminglegends": PurpleValue.GAMINGLEGENDS,
  "glider": PurpleValue.GLIDER,
  "icon": PurpleValue.ICON,
  "legendary": PurpleValue.LEGENDARY,
  "loadingscreen": PurpleValue.LOADINGSCREEN,
  "mic": PurpleValue.MIC,
  "music": PurpleValue.MUSIC,
  "outfit": PurpleValue.OUTFIT,
  "pickaxe": PurpleValue.PICKAXE,
  "rare": PurpleValue.RARE,
  "shoe": PurpleValue.SHOE,
  "skin": PurpleValue.SKIN,
  "uncommon": PurpleValue.UNCOMMON,
  "wheel": PurpleValue.WHEEL,
  "wrap": PurpleValue.WRAP
});

class Series {
  DisplayValueEnum? value;
  String? image;
  List<Color>? colors;
  SeriesBackendValue? backendValue;

  Series({
    this.value,
    this.image,
    this.colors,
    this.backendValue,
  });

  factory Series.fromJson(Map<String, dynamic> json) => Series(
        value: displayValueEnumValues.map[json["value"]]!,
        image: json["image"],
        colors: json["colors"] == null
            ? []
            : List<Color>.from(json["colors"]!.map((x) => colorValues.map[x]!)),
        backendValue: seriesBackendValueValues.map[json["backendValue"]]!,
      );

  Map<String, dynamic> toJson() => {
        "value": displayValueEnumValues.reverse[value],
        "image": image,
        "colors": colors == null
            ? []
            : List<dynamic>.from(colors!.map((x) => colorValues.reverse[x])),
        "backendValue": seriesBackendValueValues.reverse[backendValue],
      };
}

enum SeriesBackendValue { CREATOR_COLLAB_SERIES, PLATFORM_SERIES }

final seriesBackendValueValues = EnumValues({
  "CreatorCollabSeries": SeriesBackendValue.CREATOR_COLLAB_SERIES,
  "PlatformSeries": SeriesBackendValue.PLATFORM_SERIES
});

enum Color {
  THE_000_F2_BFF,
  THE_004_C71_FF,
  THE_025253_FF,
  THE_0_D0027_FF,
  THE_28085_FFF,
  THE_2_BC9_CAFF,
  THE_3_E1398_FF,
  THE_5328_D6_FF,
  THE_5_CF2_F3_FF,
  THE_8078_FFFF
}

final colorValues = EnumValues({
  "000f2bff": Color.THE_000_F2_BFF,
  "004c71ff": Color.THE_004_C71_FF,
  "025253ff": Color.THE_025253_FF,
  "0d0027ff": Color.THE_0_D0027_FF,
  "28085fff": Color.THE_28085_FFF,
  "2bc9caff": Color.THE_2_BC9_CAFF,
  "3e1398ff": Color.THE_3_E1398_FF,
  "5328d6ff": Color.THE_5328_D6_FF,
  "5cf2f3ff": Color.THE_5_CF2_F3_FF,
  "8078ffff": Color.THE_8078_FFFF
});

class Variant {
  Channel? channel;
  String? type;
  List<Option>? options;

  Variant({
    this.channel,
    this.type,
    this.options,
  });
  factory Variant.fromJson(Map<String, dynamic> json) {
    try {
      // Verifica que 'channel' no sea nulo y que exista en el mapa
      final channelValue = json["channel"];
      if (channelValue == null ||
          !channelValues.map.containsKey(channelValue)) {
        throw Exception("Invalid or missing 'channel' value");
      }

      // Devuelve el Variant con valores predeterminados si algunos campos son nulos
      return Variant(
        channel: channelValues
            .map[channelValue]!, // Asume que ahora el 'channel' es válido
        type:
            json["type"] ?? "Unknown", // Valor predeterminado si 'type' es nulo
        options: json["options"] == null
            ? [] // Si 'options' es nulo, devuelve una lista vacía
            : List<Option>.from(json["options"]!
                    .map((x) => Option.fromJson(x)) // Deserializa las opciones
                ),
      );
    } catch (e) {
      print("Error parsing Variant: $e");
      throw Exception("Failed to parse Variant: $e");
    }
  }

  // factory Variant.fromJson(Map<String, dynamic> json) => Variant(
  //       channel: channelValues.map[json["channel"]]!,
  //       type: json["type"],
  //       options: json["options"] == null
  //           ? []
  //           : List<Option>.from(
  //               json["options"]!.map((x) => Option.fromJson(x))),
  //     );

  Map<String, dynamic> toJson() => {
        "channel": channelValues.reverse[channel],
        "type": type,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

enum Channel { EMISSIVE, JERSEY_COLOR, MATERIAL, MESH, PARTICLE, PARTS }

final channelValues = EnumValues({
  "Emissive": Channel.EMISSIVE,
  "JerseyColor": Channel.JERSEY_COLOR,
  "Material": Channel.MATERIAL,
  "Mesh": Channel.MESH,
  "Particle": Channel.PARTICLE,
  "Parts": Channel.PARTS
});

class Option {
  String? tag;
  String? name;
  String? image;

  Option({
    this.tag,
    this.name,
    this.image,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        tag: json["tag"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "name": name,
        "image": image,
      };
}

class Bundle {
  String? name;
  Info? info;
  String? image;

  Bundle({
    this.name,
    this.info,
    this.image,
  });

  factory Bundle.fromJson(Map<String, dynamic> json) => Bundle(
        name: json["name"],
        info: infoValues.map[json["info"]]!,
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "info": infoValues.reverse[info],
        "image": image,
      };
}

enum Info { BUNDLE }

final infoValues = EnumValues({"Bundle": Info.BUNDLE});

class Car {
  String? id;
  String? vehicleId;
  String? name;
  String? description;
  Rarity? type;
  Rarity? rarity;
  BeanClass? images;
  Series? series;
  DateTime? added;

  Car({
    this.id,
    this.vehicleId,
    this.name,
    this.description,
    this.type,
    this.rarity,
    this.images,
    this.series,
    this.added,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        vehicleId: json["vehicleId"],
        name: json["name"],
        description: json["description"],
        type: json["type"] == null ? null : Rarity.fromJson(json["type"]),
        rarity: json["rarity"] == null ? null : Rarity.fromJson(json["rarity"]),
        images:
            json["images"] == null ? null : BeanClass.fromJson(json["images"]),
        series: json["series"] == null ? null : Series.fromJson(json["series"]),
        added: json["added"] == null ? null : DateTime.parse(json["added"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicleId": vehicleId,
        "name": name,
        "description": description,
        "type": type?.toJson(),
        "rarity": rarity?.toJson(),
        "images": images?.toJson(),
        "series": series?.toJson(),
        "added": added?.toIso8601String(),
      };
}

class EntryColors {
  String? color1;
  Color2? color2;
  String? color3;
  String? textBackgroundColor;

  EntryColors({
    this.color1,
    this.color2,
    this.color3,
    this.textBackgroundColor,
  });

  factory EntryColors.fromJson(Map<String, dynamic> json) => EntryColors(
        color1: json["color1"],
        color2: color2Values.map[json["color2"]]!,
        color3: json["color3"],
        textBackgroundColor: json["textBackgroundColor"],
      );

  Map<String, dynamic> toJson() => {
        "color1": color1,
        "color2": color2Values.reverse[color2],
        "color3": color3,
        "textBackgroundColor": textBackgroundColor,
      };
}

enum Color2 {
  THE_000000_FF,
  THE_000_A2_EFF,
  THE_011_F22_FF,
  THE_042600_FF,
  THE_091647_FF,
  THE_4_E067_CFF,
  THE_6_A0104_FF,
  THE_7_F6326_FF,
  THE_95653_AFF
}

final color2Values = EnumValues({
  "000000ff": Color2.THE_000000_FF,
  "000a2eff": Color2.THE_000_A2_EFF,
  "011f22ff": Color2.THE_011_F22_FF,
  "042600ff": Color2.THE_042600_FF,
  "091647ff": Color2.THE_091647_FF,
  "4e067cff": Color2.THE_4_E067_CFF,
  "6a0104ff": Color2.THE_6_A0104_FF,
  "7f6326ff": Color2.THE_7_F6326_FF,
  "95653aff": Color2.THE_95653_AFF
});

class Layout {
  LayoutId? id;
  Name? name;
  Category? category;
  int? index;
  int? rank;
  ShowIneligibleOffers? showIneligibleOffers;
  bool? useWidePreview;
  DisplayType? displayType;

  Layout({
    this.id,
    this.name,
    this.category,
    this.index,
    this.rank,
    this.showIneligibleOffers,
    this.useWidePreview,
    this.displayType,
  });

  factory Layout.fromJson(Map<String, dynamic> json) {
    try {
      //print("Parsing Layout: $json"); // Depuración del JSON de `layout`
      return Layout(
        id: layoutIdValues.map[json["id"]] ??
            LayoutId.AVATAR, // Valor predeterminado
        name: nameValues.map[json["name"]] ?? Name.AVATAR, // Manejo seguro
        category: categoryValues.map[json["category"]] ?? Category.ICONS,
        index: json["index"] ?? 0,
        rank: json["rank"] ?? 0,
        showIneligibleOffers:
            showIneligibleOffersValues.map[json["showIneligibleOffers"]] ??
                ShowIneligibleOffers.ALWAYS,
        useWidePreview: json["useWidePreview"] ?? false,
        displayType: displayTypeValues.map[json["displayType"]] ??
            DisplayType.EXPANDABLE_LIST,
      );
    } catch (e) {
      print("Error parsing Layout: $e");
      throw Exception("Failed to parse Layout: $e");
    }
  }

  // factory Layout.fromJson(Map<String, dynamic> json) => Layout(
  //       id: layoutIdValues.map[json["id"]]!,
  //       name: nameValues.map[json["name"]]!,
  //       category: categoryValues.map[json["category"]]!,
  //       index: json["index"],
  //       rank: json["rank"],
  //       showIneligibleOffers:
  //           showIneligibleOffersValues.map[json["showIneligibleOffers"]]!,
  //       useWidePreview: json["useWidePreview"],
  //       displayType: displayTypeValues.map[json["displayType"]]!,
  //     );

  Map<String, dynamic> toJson() => {
        "id": layoutIdValues.reverse[id],
        "name": nameValues.reverse[name],
        "category": categoryValues.reverse[category],
        "index": index,
        "rank": rank,
        "showIneligibleOffers":
            showIneligibleOffersValues.reverse[showIneligibleOffers],
        "useWidePreview": useWidePreview,
        "displayType": displayTypeValues.reverse[displayType],
      };
}

enum Category {
  ICONS,
  ROYALE_ORIGINALS,
  SPOTLIGHT,
  START_YOUR_ENGINES,
  TAKE_YOUR_STAGE
}

final categoryValues = EnumValues({
  "Icons": Category.ICONS,
  "Royale Originals": Category.ROYALE_ORIGINALS,
  "Spotlight": Category.SPOTLIGHT,
  "Start Your Engines": Category.START_YOUR_ENGINES,
  "Take Your Stage": Category.TAKE_YOUR_STAGE
});

enum DisplayType { EXPANDABLE_LIST, TILE_GRID }

final displayTypeValues = EnumValues({
  "expandableList": DisplayType.EXPANDABLE_LIST,
  "tileGrid": DisplayType.TILE_GRID
});

enum LayoutId {
  AVATAR,
  BEHEMOTH_RUBIUS,
  FORTNITE_FLOW,
  GOALBOUND,
  HERO_ACA_ALL_NEW_2,
  INFERNO,
  INSIDIO,
  JAM_TRACKS0112,
  LAZARBEAM,
  LETHAL_COMPANY,
  LOSERFRUIT,
  NICK_EH,
  NIKE_DROP10,
  RICKAND_MORTY,
  SIGNATURE_STYLE0112,
  SNOOP_DOGG1,
  SPARKS_INSTRUMENTS47,
  SUPER_OG,
  TSUZURE_BOOST
}

final layoutIdValues = EnumValues({
  "Avatar": LayoutId.AVATAR,
  "BehemothRubius": LayoutId.BEHEMOTH_RUBIUS,
  "FortniteFlow": LayoutId.FORTNITE_FLOW,
  "Goalbound": LayoutId.GOALBOUND,
  "HeroAcaAllNew-2": LayoutId.HERO_ACA_ALL_NEW_2,
  "Inferno": LayoutId.INFERNO,
  "Insidio": LayoutId.INSIDIO,
  "JamTracks0112": LayoutId.JAM_TRACKS0112,
  "Lazarbeam": LayoutId.LAZARBEAM,
  "LethalCompany": LayoutId.LETHAL_COMPANY,
  "Loserfruit": LayoutId.LOSERFRUIT,
  "NickEh": LayoutId.NICK_EH,
  "NikeDrop10": LayoutId.NIKE_DROP10,
  "RickandMorty": LayoutId.RICKAND_MORTY,
  "SignatureStyle0112": LayoutId.SIGNATURE_STYLE0112,
  "SnoopDogg1": LayoutId.SNOOP_DOGG1,
  "SparksInstruments47": LayoutId.SPARKS_INSTRUMENTS47,
  "SuperOG": LayoutId.SUPER_OG,
  "TsuzureBoost": LayoutId.TSUZURE_BOOST
});

enum Name {
  AVATAR,
  BEHEMOTH,
  FORTNITE_FLOW,
  GEAR_FOR_FESTIVAL,
  GET_YOUR_KICKS,
  GOALBOUND,
  INSIDIO,
  JAM_TRACKS,
  J_BALVIN,
  LAZARBEAM,
  LETHAL_COMPANY,
  LOSERFRUIT,
  MY_HERO_ACADEMIA,
  NICK_EH_30,
  OG_SEASON_SHOP,
  RICK_AND_MORTY,
  SIGNATURE_STYLE,
  SNOOP_DOGG,
  WHEELS_BOOSTS
}

final nameValues = EnumValues({
  "Avatar": Name.AVATAR,
  "Behemoth": Name.BEHEMOTH,
  "Fortnite Flow": Name.FORTNITE_FLOW,
  "Gear For Festival": Name.GEAR_FOR_FESTIVAL,
  "Get Your Kicks": Name.GET_YOUR_KICKS,
  "Goalbound": Name.GOALBOUND,
  "Insidio": Name.INSIDIO,
  "Jam Tracks": Name.JAM_TRACKS,
  "J Balvin": Name.J_BALVIN,
  "Lazarbeam": Name.LAZARBEAM,
  "Lethal Company": Name.LETHAL_COMPANY,
  "Loserfruit": Name.LOSERFRUIT,
  "My Hero Academia": Name.MY_HERO_ACADEMIA,
  "Nick Eh 30": Name.NICK_EH_30,
  "OG Season Shop": Name.OG_SEASON_SHOP,
  "Rick and Morty": Name.RICK_AND_MORTY,
  "Signature Style": Name.SIGNATURE_STYLE,
  "Snoop Dogg": Name.SNOOP_DOGG,
  "Wheels & Boosts": Name.WHEELS_BOOSTS
});

enum ShowIneligibleOffers { ALWAYS }

final showIneligibleOffersValues =
    EnumValues({"always": ShowIneligibleOffers.ALWAYS});

class NewDisplayAsset {
  String? id;
  String? cosmeticId;
  List<MaterialInstance>? materialInstances;
  List<RenderImage>? renderImages;

  NewDisplayAsset({
    this.id,
    this.cosmeticId,
    this.materialInstances,
    this.renderImages,
  });

  factory NewDisplayAsset.fromJson(Map<String, dynamic> json) =>
      NewDisplayAsset(
        id: json["id"],
        cosmeticId: json["cosmeticId"],
        materialInstances: json["materialInstances"] == null
            ? []
            : List<MaterialInstance>.from(json["materialInstances"]!
                .map((x) => MaterialInstance.fromJson(x))),
        renderImages: json["renderImages"] == null
            ? []
            : List<RenderImage>.from(
                json["renderImages"]!.map((x) => RenderImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cosmeticId": cosmeticId,
        "materialInstances": materialInstances == null
            ? []
            : List<dynamic>.from(materialInstances!.map((x) => x.toJson())),
        "renderImages": renderImages == null
            ? []
            : List<dynamic>.from(renderImages!.map((x) => x.toJson())),
      };
}

class MaterialInstance {
  String? id;
  PrimaryMode? primaryMode;
  ProductTag? productTag;
  MaterialInstanceImages? images;
  MaterialInstanceColors? colors;
  Map<String, double>? scalings;
  Map<String, bool>? flags;

  MaterialInstance({
    this.id,
    this.primaryMode,
    this.productTag,
    this.images,
    this.colors,
    this.scalings,
    this.flags,
  });

  factory MaterialInstance.fromJson(Map<String, dynamic> json) =>
      MaterialInstance(
        id: json["id"],
        primaryMode: primaryModeValues.map[json["primaryMode"]]!,
        productTag: productTagValues.map[json["productTag"]]!,
        images: json["images"] == null
            ? null
            : MaterialInstanceImages.fromJson(json["images"]),
        colors: json["colors"] == null
            ? null
            : MaterialInstanceColors.fromJson(json["colors"]),
        scalings: Map.from(json["scalings"]!)
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
        flags: Map.from(json["flags"]!)
            .map((k, v) => MapEntry<String, bool>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "primaryMode": primaryModeValues.reverse[primaryMode],
        "productTag": productTagValues.reverse[productTag],
        "images": images?.toJson(),
        "colors": colors?.toJson(),
        "scalings":
            Map.from(scalings!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "flags":
            Map.from(flags!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class MaterialInstanceColors {
  String? backgroundColorA;
  String? backgroundColorB;
  String? fallOffColor;
  String? floorRadialAngle;
  String? floorRadialOffset;
  String? backgroundColor1;
  String? colorCircuitBackground;
  String? colorCircuitBackground2;
  String? colorCircuitDots;
  String? colorCircuitHighlights;
  String? colorCircuitLines;
  String? colorCircuitLines2;

  MaterialInstanceColors({
    this.backgroundColorA,
    this.backgroundColorB,
    this.fallOffColor,
    this.floorRadialAngle,
    this.floorRadialOffset,
    this.backgroundColor1,
    this.colorCircuitBackground,
    this.colorCircuitBackground2,
    this.colorCircuitDots,
    this.colorCircuitHighlights,
    this.colorCircuitLines,
    this.colorCircuitLines2,
  });

  factory MaterialInstanceColors.fromJson(Map<String, dynamic> json) =>
      MaterialInstanceColors(
        backgroundColorA: json["Background_Color_A"],
        backgroundColorB: json["Background_Color_B"],
        fallOffColor: json["FallOff_Color"],
        floorRadialAngle: json["Floor Radial Angle"],
        floorRadialOffset: json["Floor Radial Offset"],
        backgroundColor1: json["Background Color 1"],
        colorCircuitBackground: json["ColorCircuitBackground"],
        colorCircuitBackground2: json["ColorCircuitBackground2"],
        colorCircuitDots: json["ColorCircuitDots"],
        colorCircuitHighlights: json["ColorCircuitHighlights"],
        colorCircuitLines: json["ColorCircuitLines"],
        colorCircuitLines2: json["ColorCircuitLines2"],
      );

  Map<String, dynamic> toJson() => {
        "Background_Color_A": backgroundColorA,
        "Background_Color_B": backgroundColorB,
        "FallOff_Color": fallOffColor,
        "Floor Radial Angle": floorRadialAngle,
        "Floor Radial Offset": floorRadialOffset,
        "Background Color 1": backgroundColor1,
        "ColorCircuitBackground": colorCircuitBackground,
        "ColorCircuitBackground2": colorCircuitBackground2,
        "ColorCircuitDots": colorCircuitDots,
        "ColorCircuitHighlights": colorCircuitHighlights,
        "ColorCircuitLines": colorCircuitLines,
        "ColorCircuitLines2": colorCircuitLines2,
      };
}

class MaterialInstanceImages {
  String? offerImage;
  String? background;
  String? carTexture;
  String? carUtil;
  String? itemStackTexture;

  MaterialInstanceImages({
    this.offerImage,
    this.background,
    this.carTexture,
    this.carUtil,
    this.itemStackTexture,
  });

  factory MaterialInstanceImages.fromJson(Map<String, dynamic> json) =>
      MaterialInstanceImages(
        offerImage: json["OfferImage"],
        background: json["Background"],
        carTexture: json["CarTexture"],
        carUtil: json["CarUtil"],
        itemStackTexture: json["ItemStackTexture"],
      );

  Map<String, dynamic> toJson() => {
        "OfferImage": offerImage,
        "Background": background,
        "CarTexture": carTexture,
        "CarUtil": carUtil,
        "ItemStackTexture": itemStackTexture,
      };
}

enum PrimaryMode { E_COSMETIC_COMPATIBLE_MODE_LEGACY_MAX }

final primaryModeValues = EnumValues({
  "ECosmeticCompatibleModeLegacy::MAX":
      PrimaryMode.E_COSMETIC_COMPATIBLE_MODE_LEGACY_MAX
});

enum ProductTag {
  PRODUCT_BR,
  PRODUCT_DEL_MAR,
  PRODUCT_JUNO,
  PRODUCT_MAX,
  PRODUCT_SPARKS
}

final productTagValues = EnumValues({
  "Product.BR": ProductTag.PRODUCT_BR,
  "Product.DelMar": ProductTag.PRODUCT_DEL_MAR,
  "Product.Juno": ProductTag.PRODUCT_JUNO,
  "Product.MAX": ProductTag.PRODUCT_MAX,
  "Product.Sparks": ProductTag.PRODUCT_SPARKS
});

class RenderImage {
  ProductTag? productTag;
  String? fileName;
  String? image;

  RenderImage({
    this.productTag,
    this.fileName,
    this.image,
  });

  factory RenderImage.fromJson(Map<String, dynamic> json) => RenderImage(
        productTag: productTagValues.map[json["productTag"]]!,
        fileName: json["fileName"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "productTag": productTagValues.reverse[productTag],
        "fileName": fileName,
        "image": image,
      };
}

class OfferTag {
  OfferTagId? id;
  String? text;

  OfferTag({
    this.id,
    this.text,
  });

  factory OfferTag.fromJson(Map<String, dynamic> json) => OfferTag(
        id: offerTagIdValues.map[json["id"]]!,
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": offerTagIdValues.reverse[id],
        "text": text,
      };
}

enum OfferTagId {
  GLASSBREAKS,
  MOONFLAXSUV,
  OUTFITLIGHTMUSIC,
  PEACH,
  PICKTHREETEAM,
  PROMODESC7,
  PROMODESC70,
  PROMODESC75,
  PROMODESC76,
  PROMODESC77,
  REACTIVELOOFAHPICKAXE,
  SPARKSJAMLOOP,
  SYNCEDEMOTEINVITE
}

final offerTagIdValues = EnumValues({
  "glassbreaks": OfferTagId.GLASSBREAKS,
  "moonflaxsuv": OfferTagId.MOONFLAXSUV,
  "outfitlightmusic": OfferTagId.OUTFITLIGHTMUSIC,
  "peach": OfferTagId.PEACH,
  "pickthreeteam": OfferTagId.PICKTHREETEAM,
  "promodesc7": OfferTagId.PROMODESC7,
  "promodesc70": OfferTagId.PROMODESC70,
  "promodesc75": OfferTagId.PROMODESC75,
  "promodesc76": OfferTagId.PROMODESC76,
  "promodesc77": OfferTagId.PROMODESC77,
  "reactiveloofahpickaxe": OfferTagId.REACTIVELOOFAHPICKAXE,
  "sparksjamloop": OfferTagId.SPARKSJAMLOOP,
  "syncedemoteinvite": OfferTagId.SYNCEDEMOTEINVITE
});

enum TileSize { SIZE_1_X_1, SIZE_2_X_1, SIZE_3_X_1, SIZE_4_X_1 }

final tileSizeValues = EnumValues({
  "Size_1_x_1": TileSize.SIZE_1_X_1,
  "Size_2_x_1": TileSize.SIZE_2_X_1,
  "Size_3_x_1": TileSize.SIZE_3_X_1,
  "Size_4_x_1": TileSize.SIZE_4_X_1
});

class Track {
  String? id;
  String? devName;
  String? title;
  String? artist;
  int? releaseYear;
  int? bpm;
  int? duration;
  Difficulty? difficulty;
  String? albumArt;
  DateTime? added;
  String? album;
  List<Genre>? genres;

  Track({
    this.id,
    this.devName,
    this.title,
    this.artist,
    this.releaseYear,
    this.bpm,
    this.duration,
    this.difficulty,
    this.albumArt,
    this.added,
    this.album,
    this.genres,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    // print("Parsing Track: $json"); // Depuración del JSON de `Track`

    try {
      return Track(
        id: json["id"] ?? "", // Valor predeterminado para id
        devName:
            json["devName"] ?? "Unknown", // Valor predeterminado para devName
        title: json["title"] ?? "Untitled", // Valor predeterminado para title
        artist: json["artist"] ??
            "Unknown Artist", // Valor predeterminado para artist
        releaseYear:
            json["releaseYear"] ?? 0, // Año por defecto si está ausente
        bpm: json["bpm"] ?? 0, // BPM por defecto
        duration: json["duration"] ?? 0, // Duración por defecto
        difficulty: json["difficulty"] == null
            ? null
            : Difficulty.fromJson(json["difficulty"]), // Manejo seguro
        albumArt: json["albumArt"] ?? "", // URL de álbum vacío si no existe
        added: json["added"] == null
            ? null
            : DateTime.tryParse(json["added"]) ??
                null, // Manejo seguro de fecha
        album:
            json["album"] ?? "Unknown Album", // Valor predeterminado para álbum
        genres: json["genres"] == null
            ? [] // Lista vacía si no hay géneros
            : List<Genre>.from(json["genres"]!.map((x) {
                return genreValues.map[x] ??
                    Genre.POP; // Valor predeterminado para géneros desconocidos
              })),
      );
    } catch (e) {
      print("Error parsing Track: $e"); // Depuración en caso de error
      throw Exception("Failed to parse Track: $e");
    }
  }

  // factory Track.fromJson(Map<String, dynamic> json) => Track(
  //       id: json["id"],
  //       devName: json["devName"],
  //       title: json["title"],
  //       artist: json["artist"],
  //       releaseYear: json["releaseYear"],
  //       bpm: json["bpm"],
  //       duration: json["duration"],
  //       difficulty: json["difficulty"] == null
  //           ? null
  //           : Difficulty.fromJson(json["difficulty"]),
  //       albumArt: json["albumArt"],
  //       added: json["added"] == null ? null : DateTime.parse(json["added"]),
  //       album: json["album"],
  //       genres: json["genres"] == null
  //           ? []
  //           : List<Genre>.from(json["genres"]!.map((x) => genreValues.map[x]!)),
  //     );

  Map<String, dynamic> toJson() => {
        "id": id,
        "devName": devName,
        "title": title,
        "artist": artist,
        "releaseYear": releaseYear,
        "bpm": bpm,
        "duration": duration,
        "difficulty": difficulty?.toJson(),
        "albumArt": albumArt,
        "added": added?.toIso8601String(),
        "album": album,
        "genres": genres == null
            ? []
            : List<dynamic>.from(genres!.map((x) => genreValues.reverse[x])),
      };
}

class Difficulty {
  int? vocals;
  int? guitar;
  int? bass;
  int? plasticBass;
  int? drums;
  int? plasticDrums;

  Difficulty({
    this.vocals,
    this.guitar,
    this.bass,
    this.plasticBass,
    this.drums,
    this.plasticDrums,
  });

  factory Difficulty.fromJson(Map<String, dynamic> json) => Difficulty(
        vocals: json["vocals"],
        guitar: json["guitar"],
        bass: json["bass"],
        plasticBass: json["plasticBass"],
        drums: json["drums"],
        plasticDrums: json["plasticDrums"],
      );

  Map<String, dynamic> toJson() => {
        "vocals": vocals,
        "guitar": guitar,
        "bass": bass,
        "plasticBass": plasticBass,
        "drums": drums,
        "plasticDrums": plasticDrums,
      };
}

enum Genre { DANCE_ELECTRONIC, POP, RAP_HIP_HOP, RN_B, ROCK }

final genreValues = EnumValues({
  "DanceElectronic": Genre.DANCE_ELECTRONIC,
  "Pop": Genre.POP,
  "RapHipHop": Genre.RAP_HIP_HOP,
  "RnB": Genre.RN_B,
  "Rock": Genre.ROCK
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
