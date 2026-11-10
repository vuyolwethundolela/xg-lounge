XG Bar & Lounge & Guesthouse - website prototype

Open the folder in VS Code, install the "Live Server" extension, right-click index.html > Open with Live Server.

Edit in index.html:
- WhatsApp number: const D={wa:'27000000000',...}  (country code, no +, e.g. 27658938239)
- Social links: search for instagram.com / facebook.com / tiktok.com in the footer
- Events: the SEED list near the top of the script (Day Dreamer flyer + teaser video in /assets)

Note: the admin portal and uploads only work on the hosted version (they need a database + file storage).

Welcome voice-over: when a visitor taps Enter, the site plays assets/welcome.mp3 if that file exists
(record "Welcome to XG Lounge and Guesthouse" in your own voice and save it with that name).
If the file is missing, the browser's built-in voice says it instead.

Sample content to replace when details are final: menu (MENU list in index.html and assets/xg-menu.pdf),
room names and rates, opening hours, address and the sample guest reviews.
