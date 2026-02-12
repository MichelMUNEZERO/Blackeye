# Quick Fix for Ngrok Link Not Generating

## Issue

The ngrok link shows empty because the authtoken is not configured on your Kali Linux system.

## Solution - Run these commands on Kali:

### Step 1: Navigate to Blackeye folder

```bash
cd ~/Desktop/Blackeye
```

### Step 2: Configure ngrok authtoken

```bash
./ngrok config add-authtoken 39ZjFtVlnmSXb4QjNGihhnNzjAZ_7RHfGMjhsvGjgYZJ5vNmU
```

### Step 3: Pull the latest fixes

```bash
git pull origin main
```

### Step 4: Run BlackEye again

```bash
./blackeye.sh
```

---

## Alternative: Use Localtunnel (No authtoken needed)

If you don't want to configure ngrok, use option 2:

### Install localtunnel

```bash
sudo npm install -g localtunnel
```

### Run BlackEye and choose option 2

```bash
./blackeye.sh
# Then select option 2 for Localtunnel
```

---

## Testing Ngrok Manually

To test if ngrok is working:

```bash
# Start a test server
php -S 127.0.0.1:8080 &

# Start ngrok
./ngrok http 8080

# You should see a URL displayed
```

---

## Common Issues

**Error: "Failed to get ngrok link"**

- Make sure authtoken is configured: `./ngrok config add-authtoken YOUR_TOKEN`
- Check if ngrok is running: `ps aux | grep ngrok`
- Verify ngrok API: `curl http://127.0.0.1:4040/api/tunnels`

**Error: "ngrok not found"**

- Run the setup script: `sudo ./setup.sh`
- Or download manually from: https://ngrok.com/download

**Error: "Shortened link: Error"**

- This is normal if the main link is empty
- The main ngrok link is what matters
