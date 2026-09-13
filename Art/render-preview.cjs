// Requires Playwright and Sharp; pass the installed Chrome path as argv[2].
const fs=require('fs'), path=require('path'), {pathToFileURL}=require('url');
const {chromium}=require('playwright'), sharp=require('sharp');
(async()=>{
 const palette=JSON.parse(fs.readFileSync(path.join(__dirname,'preview-palette.json'),'utf8'));
 const browser=await chromium.launch({executablePath:process.argv[2],headless:true});
 try {
  const page=await browser.newPage({viewport:{width:896,height:504},deviceScaleFactor:1});
  await page.goto(pathToFileURL(path.join(__dirname,'preview.html')).href);
  await page.evaluate(p=>{for(const [key,value] of Object.entries(p))document.documentElement.style.setProperty('--'+key,value);document.documentElement.style.setProperty('--veilRGB',p.veil.match(/\w\w/g).map(x=>parseInt(x,16)).join(' '));},palette);
  await page.evaluate(()=>document.fonts.ready);
  const qa=path.resolve(__dirname,'../.build/audit');fs.mkdirSync(qa,{recursive:true});
  const output=path.resolve(__dirname,'../Mod/About/Preview.png');
  await page.screenshot({path:output});
  const metrics=await page.evaluate(()=>({font:document.fonts.check('46px "Segoe UI"'),boxes:[...document.querySelectorAll('h1,p,.badge-number')].map(e=>({text:e.textContent,box:e.getBoundingClientRect().toJSON()}))}));
  await page.evaluate(()=>document.body.classList.add('no-ink'));
  const blank=path.join(qa,'preview-no-ink.png');await page.screenshot({path:blank});
  await sharp(output).resize(268).png().toFile(path.join(qa,'preview-268.png'));
  const {data,info}=await sharp(blank).removeAlpha().raw().toBuffer({resolveWithObject:true});
  const rgb=hex=>hex.match(/\w\w/g).map(x=>parseInt(x,16));
  const lum=a=>a.map(v=>v/255).map(v=>v<=.04045?v/12.92:((v+.055)/1.055)**2.4).reduce((s,v,i)=>s+v*[.2126,.7152,.0722][i],0);
  const contrast=(a,b)=>(Math.max(lum(a),lum(b))+.05)/(Math.min(lum(a),lum(b))+.05);
  let worst=100;
  // Conservative: inspect every pixel across both text rectangles, including spaces.
  for(const item of metrics.boxes.slice(0,2)){const r=item.box;for(let y=Math.floor(r.y);y<Math.ceil(r.bottom);y++)for(let x=Math.floor(r.x);x<Math.ceil(r.right);x++){const i=(y*info.width+x)*info.channels;worst=Math.min(worst,contrast([...data.subarray(i,i+3)],rgb(palette.inkPrimary)));}}
  metrics.minimumPrimaryContrast=worst;
  metrics.badgeContrast=contrast(rgb(palette.accent),rgb(palette.badgeInk));
  const r=await page.locator('.version').boundingBox();let secondary=100;
  for(let y=Math.floor(r.y);y<Math.ceil(r.y+r.height);y++)for(let x=Math.floor(r.x);x<Math.ceil(r.x+r.width);x++){const i=(y*info.width+x)*info.channels;secondary=Math.min(secondary,contrast([...data.subarray(i,i+3)],rgb(palette.inkSecondary)));}
  metrics.minimumSecondaryContrast=secondary;
  metrics.bytes=fs.statSync(output).size;
  fs.writeFileSync(path.join(qa,'preview-qa.json'),JSON.stringify(metrics,null,2));
  console.log(JSON.stringify(metrics));
  if(!metrics.font||worst<4.5||secondary<4.5||metrics.badgeContrast<4.5||metrics.bytes>=1000000)throw Error('Preview QA threshold failed');
 } finally {await browser.close();}
})().catch(e=>{console.error(e);process.exit(1)});
