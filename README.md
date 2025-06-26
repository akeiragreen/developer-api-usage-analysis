# 📊 Developer API Usage Analysis (SQL Project Aligned with Fingerprint)

**Project #4: Dev-Focused Dashboard — API Usage + SDK Adoption**

This SQL-based analysis simulates how a data analyst at [Fingerprint](https://fingerprint.com) might extract product insights, track SDK adoption, and surface suspicious behavior through raw API telemetry logs. The goal is to speak directly to Fingerprint’s developer-first model and its commitment to performance, security, and transparency.

---

## 🧠 Project Objectives

- **Understand Developer Behavior** via timestamped API logs
- **Detect Anomalies & Bots** through usage spikes and data patterns
- **Optimize SDK/API Experience** by identifying latency, peak usage, and adoption by region
- **Support Fingerprint’s Mission** to empower developers with meaningful, secure user identification data

---

## 📁 Dataset Structure (`dev_api_usage_logs`)

| Column                | Description                            |
|-----------------------|----------------------------------------|
| `src_ip`              | Source IP address of the API call      |
| `src_ip_country_code` | Country origin of the request          |
| `bytes_in` / `bytes_out` | Data volume sent and received         |
| `creation_date/time`, `end_date/time`, `event_date/time` | Raw text timestamp fields |
| `*_datetime` fields   | Unified DATETIME columns for analysis  |

---

## 🔍 Analysis Overview

### 1. **Data Preparation**

```sql
ALTER TABLE dev_api_usage_logs
ADD COLUMN creation_datetime DATETIME,
ADD COLUMN end_datetime DATETIME,
ADD COLUMN event_datetime DATETIME;

UPDATE dev_api_usage_logs
SET creation_datetime = STR_TO_DATE(CONCAT(creation_date, ' ', creation_time), '%Y-%m-%d %H:%i:%s'),
    end_datetime = STR_TO_DATE(CONCAT(end_date, ' ', end_time), '%Y-%m-%d %H:%i:%s'),
    event_datetime = STR_TO_DATE(CONCAT(event_date, ' ', event_time), '%Y-%m-%d %H:%i:%s');
