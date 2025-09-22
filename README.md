# Okul Sayaç Uygulaması
## Amacı:
Ders ve teneffüs vakitlerinden kalan sürenin ayarlananbilir bir uygulama aracılığı ile öğrenciye zilsiz bir şekilde gösterilerek öğrencinin öz denetimini geliştirmek
## Uygulanışı
1. Ders ve teneffüs süreleri daha önceden ayar panelinden ayarlanır.
2. Bilgisayar görev günü açıldığında otomatik olarak uygulamayı kiosk modunda başlatır ve sayaç devreye girer.
## Özellikleri
- Ders ve teneffüslerin ayar panelinden ayarlanabilmesi
- Ekrandaki logonun, arkaplan renginin, sayaç renginin ayar panelinden değiştirilebilmesi
- Alıntılar moduyla sayacın altında tarihteki önemli alıntıların gösterilebilmesi ve bu sözlerin ve değişim sıklığının ayar panelinedn ayarlanabilmesi
- Çoklu ders/teneffüs ekleme modu
## Gereksinimler
### Donanım Gereksinimleri
| Bileşen       | Minimum               | Önerilen                  | Notlar                                           |
| ------------- | --------------------- | ------------------------- | ------------------------------------------------ |
| CPU           | 1.5 GHz çift çekirdek | 2.0 GHz dört çekirdek     | Node.js ve Chromium’un sorunsuz çalışması için.  |
| RAM           | 1 GB                  | 4 GB veya daha fazla      | Chromium ve Node.js’in aynı anda çalışması için. |
| Depolama      | 500 MB boş alan       | 1 GB veya daha fazla      | Node.js, projeler ve Chromium cache için.        |
| Ekran         | 1024x768              | 1920x1080 veya daha fazla | Kiosk modunda düzgün görüntü için.               |
| Ağ Bağlantısı | Opsiyonel             | Hızlı internet            | Güncellemeler ve GitHub versiyon kontrolü için.  |

### Yazılım Gereksinimleri
| Bileşen        | Minimum Sürüm             | Notlar                                                        |
| -------------- | ------------------------- | ------------------------------------------------------------- |
| Node.js        | 18.x veya üstü            | Sunucu tarafı JavaScript için.                                |
| npm            | 9.x veya üstü             | Node.js paketleri için.                                       |
| Web tarayıcısı | Chromium 90+ / Chrome 90+ | Kiosk modunda HTML dosyasını göstermek için.                  |
| Bash           | 5.x                       | Linux otomasyon scripti için.                                 |
| systemd        | 245+                      | Linux açılışta servis oluşturmak için.                        |
| curl veya wget | Herhangi                  | Node.js yükleme scripti için.                                 |
| git            | Herhangi (Opsiyonel)      | GitHub’dan güncelleme çekmek için, temel çalışmaya gerek yok. |


## Uyumluluk
- Linux (Tam destek)
  - Ubuntu 20.04 / 22.04 LTS
  - Debian 10 / 11
  - Fedora 35+
  - CentOS 8+
  - Mint 21+
  - Özellik: systemd desteği, Bash script ve Chromium kiosk modu sorunsuz çalışır.
- Windows
  - Windows 10 / 11 Pro veya Home
  - Özellik: Node.js ve Chrome/Chromium kurulu olmalı, otomatik açılış için Task Scheduler kullanılır.
- macOS
  - macOS 12 (Monterey) veya üstü
  - Özellik: Node.js ve Chrome/Chromium kurulu olmalı, otomatik açılış LaunchAgents ile yapılabilir.
  - Not: Linux Bash script’i tam uyumlu değildir, ufak uyarlamalar gerekebilir.
