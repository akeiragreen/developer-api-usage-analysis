# 📊 Developer API Usage SQL Analysis

This project analyzes suspicious and high-volume developer API usage using SQL. It transforms raw log data into actionable insights that could support **engineering, product, and security teams** — especially at companies like **Fingerprint** that focus on fraud prevention, SDK adoption, and developer-first infrastructure.

---

## 🚀 Why This Project Matters

APIs are the backbone of modern software — especially for tools used by developers. But behind every endpoint hit lies behavior: user sessions, bot traffic, usage surges, or potential abuse.

This project explores those behavioral patterns using SQL — uncovering:
- Where API usage is coming from
- When it's most active
- How users interact with the SDK/API
- Whether some users exhibit suspicious behavior (e.g., scraping)

By running these queries, we simulate the kind of internal telemetry monitoring and product analytics that helps dev-centric companies grow safely and intelligently.

---

## 🧠 Questions This Project Answers

✅ **What are the most active IP addresses and countries accessing the API?**  
→ We identify top IPs by hourly request volume to flag potential anomalies.

✅ **What time of day sees the most API traffic?**  
→ We find peak usage hours to help plan for uptime, support, and scaling.

✅ **Are there scraping-like patterns in the logs?**  
→ We flag IPs sending disproportionately high bytes out with low bytes in.

✅ **How long are typical sessions?**  
→ By comparing start and end timestamps, we analyze consistent session lengths.

✅ **Which regions show the most developer/API engagement?**  
→ By grouping IPs by country, we reveal high-usage markets.

---

## 📂 SQL Breakdown

### 1. Preview & Normalize Data
- Check table contents
- Combine raw date/time columns into usable `DATETIME` fields

### 2. High-Volume Activity Detection
- Group by IP + country + hour to find spikes
- Useful for bot detection or monitoring rate limits

### 3. Peak Hour Analysis
- Determine when developers/API users are most active globally

### 4. Suspicious Data Transfer Detection
- Identify IPs with high outbound data volumes (possible scrapers)

### 5. Session Duration Calculation
- Analyze typical API session lengths using timestamp diffs

### 6. Regional Engagement Mapping
- Compare total API events and unique IPs per country

---

## 🎯 Project Purpose

To simulate how a data analyst can use SQL to:
- **Monitor API usage trends**
- **Improve SDK adoption visibility**
- **Support engineering with real product behavior**
- **Enhance security by detecting unusual activity**

This type of analysis aligns directly with companies like **Fingerprint** who prioritize **developer trust, telemetry, performance, and protection.**

---

## 🛠 Tools Used

- SQL (MySQL 8+)
- Raw CSV telemetry logs from Kaggle (cleaned & imported)
- Timestamp normalization and time-based analysis

---

## 👤 Author

**Akeira Green**  
Data Analyst | Developer Insights | Product Telemetry  
📎 [LinkedIn](https://www.linkedin.com/in/akeira-green) | 🌐 [Portfolio](https://whimsical-souffle-c10945.netlify.app/)

---

> _“Your API data tells a story — this project shows how to listen.”_
