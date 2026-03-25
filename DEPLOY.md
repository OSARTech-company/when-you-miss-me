# Share This Site Online

## Option 1: Cloudflare Pages (recommended, no sleep)
### Dashboard method
1. Go to https://dash.cloudflare.com/
2. Open `Workers & Pages` -> `Create` -> `Pages` -> `Upload assets`.
3. Project name: `blessing-love-notes` (or any name you prefer).
4. Upload this folder contents:
   - `index.html`
   - `assets/`
   - `manifest.webmanifest`
   - `service-worker.js`
5. Deploy and copy your live URL.

### CLI method
1. Install Wrangler:
   - `npm install -g wrangler`
2. Login:
   - `wrangler login`
3. From this project folder, deploy:
   - `wrangler pages deploy . --project-name blessing-love-notes`
4. Or run prepared script:
   - `powershell -ExecutionPolicy Bypass -File .\deploy-cloudflare.ps1`

## Option 2: Netlify Drop (fastest no-account drag and drop)
1. Open https://app.netlify.com/drop
2. Drag the whole project folder (`bbb`) into the page.
3. Netlify gives you a live link immediately.
4. Send that link to Blessing.

## Option 3: GitHub Pages
1. Create a new GitHub repo and upload:
   - `index.html`
   - `assets/` folder
   - `manifest.webmanifest`
   - `service-worker.js`
   - `DEPLOY.md` (optional)
2. In GitHub, go to `Settings -> Pages`.
3. Under `Build and deployment`, set:
   - `Source`: Deploy from a branch
   - `Branch`: `main` and `/ (root)`
4. Save and wait about 1 to 3 minutes.
5. Your link will be:
   - `https://<your-username>.github.io/<repo-name>/`

## Before sharing
1. Add your real photos and voice notes in `assets/`.
2. Open `index.html` locally once to confirm everything loads.
3. Re-upload if you replaced media after first deploy.
4. PWA install/offline features work best on HTTPS hosts (Cloudflare/Netlify/GitHub Pages are fine).
