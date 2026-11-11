# Build script for BrightBreak Play -> Hostinger public_html structure
$ErrorActionPreference = "Stop"

$distDir = Join-Path $PSScriptRoot "dist"
$assetsDir = Join-Path $distDir "assets"
$zipPath = Join-Path $PSScriptRoot "BrightBreak_Play_Hostinger.zip"

Write-Host "Iniciando build de producao para Hostinger..."

# 1. Limpar / Criar diretorios
if (Test-Path $distDir) {
    Remove-Item -Path $distDir -Recurse -Force
}
New-Item -ItemType Directory -Path $assetsDir -Force | Out-Null

# 2. Copiar imagens para assets/
$images = @("hero.png", "preview_03.png", "preview_08.png", "preview_12.png")
foreach ($img in $images) {
    $srcImg = Join-Path $PSScriptRoot $img
    if (Test-Path $srcImg) {
        Copy-Item -Path $srcImg -Destination (Join-Path $assetsDir $img) -Force
    } else {
        Write-Warning "Imagem nao encontrada: $srcImg"
    }
}

# 3. Gerar assets/styles.css
$cssContent = @'
:root {--forest:#173D35;--cream:#FFF9EC;--mint:#CFE7D9;--peach:#FA8069;--gold:#FFBF61;--ink:#25493F;--muted:#60746B;--white:#fff;--shadow:0 20px 50px #173d3514;}
*,*::before,*::after{box-sizing:border-box}html{scroll-behavior:smooth}body{margin:0;background:var(--cream);color:var(--ink);font:16px/1.6 system-ui,-apple-system,'Segoe UI',Arial,sans-serif}a{color:inherit}img{max-width:100%;height:auto}h1,h2,h3,p{margin-top:0}h1,h2,h3{line-height:1.12;letter-spacing:-.035em;color:var(--forest)}h1{font-size:clamp(2.7rem,5.7vw,5.2rem)}h2{font-size:clamp(2rem,4vw,3.1rem)}h3{font-size:1.23rem}.container{width:min(1100px,calc(100% - 40px));margin:auto}.section{padding:88px 0}.section-sm{padding:52px 0}.btn{display:inline-flex;align-items:center;justify-content:center;gap:12px;padding:16px 25px;border-radius:99px;text-decoration:none;font-weight:850;background:var(--peach);color:#163b33;box-shadow:0 10px 25px #fa80692c;transition:transform .15s;line-height:1.25;text-align:center;min-height:54px}.btn:hover{transform:translateY(-2px)}.btn:focus-visible,summary:focus-visible{outline:3px solid #175f79;outline-offset:3px}.btn-dark{background:var(--forest);color:white}.eyebrow{font-weight:850;letter-spacing:.13em;text-transform:uppercase;font-size:.77rem}.mini-pill{display:inline-flex;align-items:center;gap:7px;border-radius:99px;padding:9px 15px;background:#fff;color:#20443a;font-weight:750;font-size:.82rem}.muted{color:var(--muted)}.small{font-size:.86rem}.nav{border-bottom:1px solid #173d3515}.nav-inner{display:flex;justify-content:space-between;gap:14px;align-items:center;min-height:78px}.brand{font-weight:950;letter-spacing:.02em;font-size:1.18rem;text-decoration:none;color:var(--forest)}.brand b{color:#EA735D}.nav-link{font-size:.91rem;font-weight:800;text-decoration:none}.hero{padding:70px 0 80px;background:linear-gradient(145deg,#d4ebe0,#f1f6e5)}.hero-grid{display:grid;grid-template-columns:1.12fr .88fr;align-items:center;gap:60px}.hero h1{margin:22px 0 19px;max-width:640px}.hero p{font-size:1.11rem;max-width:590px}.hero .btn{margin-top:10px}.hero-image{position:relative}.hero-image .preview{width:100%;border-radius:22px;box-shadow:var(--shadow);background:#fff}.hero-foot{display:flex;align-items:center;flex-wrap:wrap;gap:8px 20px;margin-top:20px;color:#335f53;font-size:.85rem;font-weight:750}.stats{display:grid;grid-template-columns:repeat(3,1fr);gap:16px;margin-top:-31px;position:relative}.stat{background:#fff;border:1px solid #dfebde;padding:26px 22px;border-radius:18px;box-shadow:var(--shadow)}.stat strong{display:block;font-size:1.2rem;color:var(--forest)}.stat span{font-size:.83rem;color:var(--muted)}.center{text-align:center}.intro{max-width:700px;margin:0 auto 36px}.three{display:grid;grid-template-columns:repeat(3,1fr);gap:19px}.card{background:white;padding:26px;border:1px solid #e2eadf;border-radius:20px;box-shadow:0 8px 22px #173d3508}.step{display:flex;align-items:center;justify-content:center;width:46px;height:46px;border-radius:15px;background:var(--mint);color:var(--forest);font-weight:950;font-size:1.2rem;margin-bottom:22px}.teal{background:#e9f4ec}.preview-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:24px;align-items:start;margin-top:34px}.preview-card{background:#fff;border-radius:20px;padding:15px;box-shadow:var(--shadow)}.preview-card img{border:1px solid #e4eee8;display:block;border-radius:10px}.preview-card p{font-weight:760;text-align:center;margin:12px 0 5px}.checklist{list-style:none;padding:0;margin:26px 0;display:grid;gap:14px}.checklist li{display:flex;gap:12px}.checklist li::before{content:'✓';display:grid;place-items:center;flex:0 0 26px;height:26px;border-radius:50%;background:var(--mint);font-weight:900}.split{display:grid;grid-template-columns:1fr 1fr;gap:70px;align-items:center}.bonus-box{padding:33px;background:white;border-radius:23px;border:1px solid #e4ece5;box-shadow:var(--shadow)}.bonus-box ul{padding-left:18px;margin:15px 0 0}.bonus-box li{margin-bottom:10px}.highlight{color:#C45442}.price-card{max-width:750px;margin:auto;padding:46px;border-radius:29px;background:var(--forest);color:#fff;box-shadow:0 25px 60px #173d3526;text-align:center}.price-card h2{color:#fff}.price{font-size:4.35rem;line-height:1.2;letter-spacing:-.055em;font-weight:950;margin:6px 0 15px}.price-card .btn{min-width:260px;margin:14px 0 10px}.price-card .muted{color:#d7e5dc}.inside{display:flex;justify-content:center;flex-wrap:wrap;gap:10px;margin:21px 0}.inside span{font-size:.9rem;padding:8px 12px;border:1px solid #6c9c8e;border-radius:100px}.faq{max-width:780px;margin:auto}.faq details{background:#fff;border:1px solid #e0ece0;border-radius:16px;margin-bottom:11px;padding:18px 21px}.faq summary{font-weight:820;cursor:pointer}.faq p{margin:11px 0 0;color:#506a62}.footer{background:var(--forest);padding:42px 0;color:#dceae4}.footer p{max-width:730px}.footer .brand{color:white}.notice{max-width:740px;font-size:.83rem;margin:20px auto 0;text-align:center;color:var(--muted)}.sticky{display:none}.setup-note{margin:13px auto 0;max-width:570px;color:#d6e4dd;font-size:.79rem}.hero .img-label{position:absolute;bottom:15px;left:15px;font-size:.76rem;background:#ffffffe6;padding:7px 12px;border-radius:12px;font-weight:800}.details{font-size:.85rem;line-height:1.5}#checkout-warning{border-left:4px solid #f3b95d;background:#fff4da;color:#5b4630;padding:16px 20px;border-radius:7px;margin:25px auto 0;max-width:760px;display:none}.fine{font-size:.78rem;line-height:1.55}.only-audience{position:absolute;left:-10000px;top:auto;width:1px;height:1px;overflow:hidden}@media(max-width:830px){.hero-grid,.split{grid-template-columns:1fr;gap:36px}.hero-grid .hero-image{max-width:600px}.stats{grid-template-columns:1fr 1fr}.three,.preview-grid{grid-template-columns:1fr 1fr}.section{padding:62px 0}.split{gap:22px}}@media(max-width:620px){.hero{padding:42px 0 60px}.hero p{font-size:1.03rem}.hero h1{font-size:2.8rem}.stats{grid-template-columns:1fr;gap:11px;margin-top:-18px}.stat{padding:15px 20px}.three,.preview-grid{grid-template-columns:1fr}.preview-grid{max-width:410px;margin:28px auto}.price-card{padding:33px 23px}.price{font-size:3.8rem}.sticky{display:block;position:fixed;z-index:4;bottom:0;left:0;right:0;background:#fffefaee;border-top:1px solid #dfece6;backdrop-filter:blur(12px);padding:10px 16px calc(10px + env(safe-area-inset-bottom));box-shadow:0 -7px 22px #0000000c}.sticky .btn{display:flex;min-height:49px}.footer{padding-bottom:130px}.nav-inner{min-height:62px}.nav-link{font-size:.82rem}}@media(prefers-reduced-motion:reduce){html{scroll-behavior:auto}.btn{transition:none}}
'@
[System.IO.File]::WriteAllText((Join-Path $assetsDir "styles.css"), $cssContent, [System.Text.Encoding]::UTF8)

# 4. Gerar assets/script.js
$jsContent = @'
// Replace with the exact verified, hosted checkout address AFTER it has been created and tested.
const CHECKOUT_URL = 'YOUR_VERIFIED_CHECKOUT_URL_HERE';
const hasCheckout = /^https:\/\//.test(CHECKOUT_URL);
document.querySelectorAll('[data-checkout-link]').forEach(link => {
  if (hasCheckout) { link.href = CHECKOUT_URL; link.rel = 'noopener noreferrer'; }
  else { link.addEventListener('click', e => { e.preventDefault(); document.getElementById('checkout-warning').style.display = 'block'; document.getElementById('checkout-warning').scrollIntoView({behavior:'smooth'}); }); }
});
'@
[System.IO.File]::WriteAllText((Join-Path $assetsDir "script.js"), $jsContent, [System.Text.Encoding]::UTF8)

# 5. Gerar dist/index.html apontando para assets
$htmlContent = @'
<!doctype html>
<html lang="en-US">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="theme-color" content="#173D35">
  <meta name="description" content="Fourteen original printable adventures for ages 4–7. Less planning, more screen-free play. BrightBreak Play is a one-time $17 digital kit.">
  <meta property="og:title" content="BrightBreak Play | 14 Little Adventures">
  <meta property="og:description" content="Little adventures. Big screen-free moments. 14 printable missions for everyday family play.">
  <title>BrightBreak Play | 14 Little Adventures</title>
  <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
<header class="nav"><div class="container nav-inner"><a class="brand" href="#top" aria-label="BrightBreak Play home">☀ BrightBreak <b>PLAY</b></a><a class="nav-link" href="#offer">Get the activity kit →</a></div></header>
<main id="top">
  <section class="hero"><div class="container hero-grid">
    <div><span class="mini-pill">✦ AGES 4–7 · PRINT & PLAY</span><h1>Little adventures.<br>Big screen-free moments.</h1><p>Fourteen playful, ready-to-print activities for those everyday moments when you want an easy idea—not another app or a complicated project.</p><a class="btn" href="#offer">Explore the 7-day kit · $17 →</a><div class="hero-foot"><span>✓ One-time purchase</span><span>✓ Digital PDF</span><span>✓ No special supplies</span></div></div>
    <div class="hero-image"><img class="preview" src="assets/hero.png" width="1920" height="1080" alt="BrightBreak Play banner showing sample activity cards and the fourteen-adventure concept"><span class="img-label">Original printable activity kit</span></div>
  </div></section>
  <div class="container stats" aria-label="Product information"><div class="stat"><strong>14 little missions</strong><span>Drawing, stories, and imaginative play</span></div><div class="stat"><strong>7 easy days</strong><span>A suggested routine—not homework</span></div><div class="stat"><strong>Print & repeat</strong><span>Use the pages within your own household</span></div></div>
  <section class="section"><div class="container"><div class="intro center"><span class="eyebrow muted">Less planning. More playing.</span><h2>Simple fun, one page at a time.</h2><p>There's no perfect craft project to finish. Just a little story, a few easy instructions, and space for your child's imagination.</p></div><div class="three"><article class="card"><div class="step">1</div><h3>Pick a mission</h3><p>Choose a playful prompt from the included seven-day plan.</p></article><article class="card"><div class="step">2</div><h3>Grab paper and colors</h3><p>Print a page or recreate the idea using plain paper.</p></article><article class="card"><div class="step">3</div><h3>Play it your way</h3><p>Follow the story, draw, imagine, and make up your own ending.</p></article></div></div></section>
  <section class="section teal"><div class="container"><div class="center"><span class="eyebrow muted">Real pages from the downloadable PDF</span><h2>Take a look inside.</h2><p class="intro">These previews show actual pages included in the main kit.</p></div><div class="preview-grid"><div class="preview-card"><img loading="lazy" src="assets/preview_03.png" alt="Example Color Quest printable activity page" width="765" height="990"><p>Color Quest</p></div><div class="preview-card"><img loading="lazy" src="assets/preview_08.png" alt="Example Story Starter printable activity page" width="765" height="990"><p>Story Starter</p></div><div class="preview-card"><img loading="lazy" src="assets/preview_12.png" alt="Example Treasure Checklist printable activity page" width="765" height="990"><p>Treasure Checklist</p></div></div></div></section>
  <section class="section"><div class="container split"><div><span class="eyebrow muted">Everything in one download</span><h2>Fourteen little ideas with room to make them your own.</h2><p>Explore playful missions like <strong>Color Quest</strong>, <strong>Shape City</strong>, <strong>Story Starter</strong>, <strong>Sound Safari</strong> and more.</p><ul class="checklist"><li>14 original printable activities</li><li>One simple Start Here guide</li><li>One celebration page</li><li>A suggested 7-day play routine</li><li>US Letter size PDF for easy home printing</li></ul></div><div class="bonus-box"><span class="eyebrow highlight">Included at no extra charge</span><h3>Three practical bonuses</h3><p class="muted">Keep the small things ready so you can spend less time planning.</p><ul><li><strong>Parent Quick-Start Card</strong> — one-page routine</li><li><strong>Everyday Supplies Checklist</strong> — simple items to gather</li><li><strong>7-Day Activity Planner</strong> — a playful weekly plan</li></ul><p class="small muted">A printing and family-use guide is also included. These files are part of the main $17 download.</p></div></div></section>
  <section class="section teal" id="offer"><div class="container"><div class="price-card"><span class="eyebrow">BRIGHTBREAK PLAY · DIGITAL STARTER KIT</span><h2>Ready for your next little adventure?</h2><p>14 original missions + 3 bonus resources. One easy week of playful ideas for ages 4–7.</p><div class="price" aria-label="Seventeen US dollars">$17</div><p class="muted">One-time purchase · No subscription · No physical shipping</p><div class="inside"><span>14 original missions</span><span>3 bonus resources</span><span>Instant digital access*</span></div><a class="btn" href="#checkout-warning" data-checkout-link>Get BrightBreak Play for $17 →</a><p class="setup-note">*Instant access requires your payment and delivery platform to be connected. This demonstration site is not yet taking orders.</p></div><div id="checkout-warning" role="status" aria-live="polite"><strong>Store setup required.</strong> A payment link has not been connected. Replace the checkout placeholder in the HTML with the real hosted checkout URL before promoting this page.</div></div></section>
  <section class="section"><div class="container faq"><div class="center"><h2>Questions? We have answers.</h2></div>
    <details><summary>What ages is BrightBreak Play made for?</summary><p>The activities are designed as a starting point for children ages 4–7, with an adult helping adapt them to each child's abilities and interests.</p></details>
    <details><summary>Is this a physical product?</summary><p>No. It's a downloadable digital PDF for printing at home. Nothing is shipped.</p></details>
    <details><summary>Do I need a printer?</summary><p>Printing is convenient, but an adult can read each mission and recreate it on plain paper.</p></details>
    <details><summary>Will I need special craft supplies?</summary><p>No. A pencil, crayons, and everyday safe objects are enough for most missions.</p></details>
    <details><summary>How long does each activity take?</summary><p>About ten minutes is a suggested starting point. Keep going—or stop—according to your child's interest.</p></details>
    <details><summary>Can I print an activity again?</summary><p>Yes, for personal use within your own household. Public sharing, resale, and redistribution are not permitted.</p></details>
    <details><summary>Does this treat attention difficulties or improve learning scores?</summary><p>No. BrightBreak Play is a recreational family activity kit and makes no medical, therapeutic, or academic performance claims.</p></details>
    <details><summary>How are payments and refunds handled?</summary><p>Payments and delivery are not connected on this demonstration page. The live store must publish accurate payment and refund terms before taking orders.</p></details>
  </div></section>
  <section class="section-sm teal center"><div class="container"><h2>Your next little adventure starts here.</h2><p>Choose a playful page, grab some colors, and make the moment your own.</p><a class="btn btn-dark" href="#offer">Explore BrightBreak Play · $17 →</a></div></section>
</main>
<footer class="footer"><div class="container"><a class="brand" href="#top">☀ BrightBreak PLAY</a><p>Original printable activities for adults and the children in their care.</p><p class="fine">© 2026 BrightBreak Play (provisional brand). Development asset. Before launch, add the actual legal seller name, contact email, privacy policy, terms, refund policy, tax disclosures, and verified payment integration. Do not request personal data from children.</p></div></footer>
<div class="sticky"><a class="btn" href="#offer">Get the 14-Activity Kit · $17 →</a></div>
<script src="assets/script.js"></script>
</body>
</html>
'@
[System.IO.File]::WriteAllText((Join-Path $distDir "index.html"), $htmlContent, [System.Text.Encoding]::UTF8)

# 6. Criar BrightBreak_Play_Hostinger.zip com os conteudos INTERNOS de dist
# Garantir barras normais '/' nos nomes de entrada para total compatibilidade com Linux/Hostinger
if (Test-Path $zipPath) {
    Remove-Item -Path $zipPath -Force
}

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$zip = [System.IO.Compression.ZipFile]::Open($zipPath, [System.IO.Compression.ZipArchiveMode]::Create)
$distFiles = Get-ChildItem -Path $distDir -Recurse -File
foreach ($file in $distFiles) {
    $relativePath = $file.FullName.Substring($distDir.Length).TrimStart('\', '/').Replace('\', '/')
    [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $file.FullName, $relativePath, [System.IO.Compression.CompressionLevel]::Optimal) | Out-Null
}
$zip.Dispose()

Write-Host "Build concluido com sucesso!"
Write-Host "Pasta dist gerada em: $distDir"
Write-Host "Arquivo ZIP gerado em: $zipPath"
