const express = require('express');
const fs = require('fs');
const path = require('path');
const multer = require('multer');

const app = express();
const PORT = 3000;
const DATA_FILE = path.join(__dirname, 'ayarlar.json');

// --- JSON için ---
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(__dirname));

// --- Logo upload için ---
const uploadDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadDir)) fs.mkdirSync(uploadDir);

const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, uploadDir),
  filename: (req, file, cb) => {
    // Eski logoları sil
    const files = fs.readdirSync(uploadDir);
    files.forEach(f => fs.unlinkSync(path.join(uploadDir, f)));

    // Yeni logoyu kaydet
    cb(null, 'logo' + path.extname(file.originalname));
  }
});
const upload = multer({ storage });

// --- Dosya kontrol ---
function ensureFile() {
  if (!fs.existsSync(DATA_FILE)) {
    fs.writeFileSync(DATA_FILE, JSON.stringify({ logoVersion: 0, logoWidth: 200 }, null, 2), 'utf8');
    console.log('[INIT] Oluşturuldu:', DATA_FILE);
  }
}

// --- API: get ayarlar ---
app.get('/api/get', (req, res) => {
  try {
    ensureFile();
    const raw = fs.readFileSync(DATA_FILE, 'utf8');
    const data = raw.trim() ? JSON.parse(raw) : {};
    res.json(data);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// --- API: save ayarlar ---
app.post('/api/save', (req, res) => {
  try {
    const newData = req.body || {};
    const oldData = fs.existsSync(DATA_FILE) ? JSON.parse(fs.readFileSync(DATA_FILE, 'utf8')) : {};
    const mergedData = { ...oldData, ...newData };
    fs.writeFileSync(DATA_FILE, JSON.stringify(mergedData, null, 2), 'utf8');
    res.json({ status: 'ok', saved: mergedData });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// --- API: logo upload ---
app.post('/api/upload-logo', upload.single('logo'), (req, res) => {
  try {
    ensureFile();
    const data = JSON.parse(fs.readFileSync(DATA_FILE, 'utf8'));

    // Logo versiyonu artar
    data.logoVersion = (data.logoVersion || 0) + 1;

    // Logo genişliği kaydedilebilir
    if (req.body.logoWidth) data.logoWidth = parseInt(req.body.logoWidth);

    fs.writeFileSync(DATA_FILE, JSON.stringify(data, null, 2), 'utf8');

    res.json({
      status: 'ok',
      filename: req.file.filename,
      logoVersion: data.logoVersion,
      logoWidth: data.logoWidth || 200
    });
  } catch (err) {
    res.status(500).json({ status: 'error', message: err.message });
  }
});

// --- API: logo göster ---
app.get('/api/logo', (req, res) => {
  try {
    const files = fs.readdirSync(uploadDir);
    const logoFile = files.find(f => f.startsWith('logo'));
    if (logoFile) {
      res.sendFile(path.join(uploadDir, logoFile));
    } else {
      res.status(404).send('Logo yok');
    }
  } catch (err) {
    res.status(500).send('Hata: ' + err.message);
  }
});

// --- API: logo genişliği ayarlama ---
app.post('/api/logo-width', (req, res) => {
  try {
    ensureFile();
    const data = JSON.parse(fs.readFileSync(DATA_FILE, 'utf8'));
    data.logoWidth = parseInt(req.body.width) || 200;
    fs.writeFileSync(DATA_FILE, JSON.stringify(data, null, 2), 'utf8');
    res.json({ status: 'ok', logoWidth: data.logoWidth });
  } catch (err) {
    res.status(500).json({ status: 'error', message: err.message });
  }
});

// --- API: logo versiyonu ---
app.get('/api/logo-version', (req, res) => {
  try {
    ensureFile();
    const data = JSON.parse(fs.readFileSync(DATA_FILE, 'utf8'));
    res.json({ logoVersion: data.logoVersion || 0 });
  } catch (err) {
    res.status(500).json({ status: 'error', message: err.message });
  }
});

// Yerel sürümü döndüren endpoint
app.get('/version', (req, res) => {
  try {
    ensureFile(); // ayarlar.json varsa yoksa oluştur
    const versionPath = path.join(__dirname, '.version');
    if (!fs.existsSync(versionPath)) {
      fs.writeFileSync(versionPath, '1.0.0', 'utf8'); // varsayılan sürüm
    }
    const localVersion = fs.readFileSync(versionPath, 'utf8').trim();
    res.send(localVersion);
  } catch (err) {
    res.status(500).send('Yerel sürüm dosyası okunamadı: ' + err.message);
  }
});


app.listen(PORT, () => {
  console.log(`Server çalışıyor: http://localhost:${PORT}`);
  console.log(`ayarlar.json yolu: ${DATA_FILE}`);
});
