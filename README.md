# OkulSayac

## Amaç

Ders ve teneffüs sürelerinden kalan zamanı, zilsiz ve görsel bir sayaç aracılığıyla öğrenciye göstermek. Bu sayede öğrencinin öz denetimi geliştirilir.

## Uygulama

* Ders ve teneffüs süreleri ayar panelinden belirlenir.
* Bilgisayar açıldığında uygulama **kiosk modunda** başlar ve sayaç devreye girer.

## Özellikler

* Ders ve teneffüs sürelerini ayar panelinden değiştirebilme
* Ekran logosu, arka plan rengi ve sayaç rengini özelleştirme
* Alıntılar moduyla, sayaç altında tarihsel alıntıları gösterme ve bunların sıklığını ayarlama
* Çoklu ders ve teneffüs ekleme desteği

## Gereksinimler

### Donanım

| Bileşen  | Minimum               | Önerilen              |
| -------- | --------------------- | --------------------- |
| CPU      | 1.5 GHz çift çekirdek | 2.0 GHz dört çekirdek |
| RAM      | 1 GB                  | 4 GB veya daha fazla  |
| Depolama | 500 MB                | 1 GB veya daha fazla  |
| Ekran    | 1024x768              | 1920x1080 veya üstü   |
| Ağ       | Opsiyonel             | Hızlı internet        |

### Yazılım

| Bileşen        | Minimum Sürüm   | Notlar                     |
| -------------- | --------------- | -------------------------- |
| Node.js        | 18.x            | Sunucu tarafı JS           |
| npm            | 9.x             | Node paketleri             |
| Tarayıcı       | Chrome/Edge 90+ | Kiosk modunda çalışır      |
| Linux script   | Bash 5.x        | Linux otomasyon için       |
| Windows script | Batch           | Başlangıç ve Node kontrolü |
| Git            | Opsiyonel       | Güncelleme için            |

## Uyumluluk

* **Linux:** Ubuntu 20.04+, Debian 10+, Fedora 35+, CentOS 8+, Mint 21+
* **Windows:** 10 / 11 Pro veya Home
* **macOS:** 12 (Monterey) ve üstü (script uyarlama gerekebilir)

## Kurulum

### Windows

1. Projeyi klonlayın veya indirin:

```bat
git clone https://github.com/kullaniciadi/OkulSayac.git
cd OkulSayac
```

2. Scripti çalıştırın:

```bat
OkulSayac.bat
```

3. Başlangıçtan kaldırmak için:

```bat
remove_startup.bat
```

### Linux

1. Projeyi klonlayın veya indirin:

```bash
git clone https://github.com/kullaniciadi/OkulSayac.git
cd OkulSayac
```

2. Scripti çalıştırılabilir yapın:

```bash
chmod +x OkulSayac.sh OkulSayac_remove.sh
```

3. Scripti başlatın:

```bash
./OkulSayac.sh
```

4. Başlangıçtan kaldırmak için:

```bash
./OkulSayac_remove.sh
```

