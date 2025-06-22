from pathlib import Path

# Define the README content
readme_content = """
# 🎵 Harmony Hub: Music Streaming Data Warehouse

## Project Overview
**Harmony Hub** is a data warehouse solution designed for a music streaming service. Built on **Snowflake**, the project aims to centralize, manage, and analyze large-scale music data, enabling robust analytical insights for business intelligence, genre trend detection, user behavior analysis, and artist popularity studies.

---

## 📐 Architecture Overview

The solution follows a cloud-native **ELT (Extract, Load, Transform)** pipeline architecture:

1. **Raw Data Ingestion**
   - Formats: CSV, JSON, Parquet
   - Sources: User profiles, subscriptions, session logs, track/album/genre metadata
   - Ingested into Snowflake staging using `COPY INTO`.

2. **Data Transformation**
   - SQL-based transformation in Snowflake
   - Normalization and surrogate key generation
   - Structured into:
     - Fact Tables: `fact_sessions`, `fact_user_subscriptions`, `bridge_track_genres`
     - Dimension Tables: `dim_users`, `dim_tracks`, `dim_genres`, `dim_artists`, `dim_albums`, `dim_subscriptions`, `dim_date`

3. **Analytics Layer**
   - Data connected to **Power BI** in Import Mode
   - Interactive dashboards: executive summary, user segmentation, artist/genre analysis

---

## 📊 Entity Relationship Design

The schema captures key relationships and normalizations for:

- **Users & Subscriptions**: `users`, `subscriptions`, `user_subscriptions`
- **Tracks & Genres**: `tracks`, `genres`, `tracks_genres`
- **Artists & Albums**: `artists`, `albums`
- **Streaming Sessions**: `sessions`

> Includes many-to-many bridges (e.g., `tracks_genres`, `user_subscriptions`) and proper foreign key constraints for referential integrity.

---

## 🧠 Dimensional Model (Star Schema)

### 📁 Dimensions
| Table            | Description                        |
|------------------|------------------------------------|
| `dim_users`      | User demographics & subscription   |
| `dim_artists`    | Artist metadata                    |
| `dim_albums`     | Album details                      |
| `dim_tracks`     | Track metadata                     |
| `dim_genres`     | Genre classification               |
| `dim_subscriptions` | Subscription plans              |
| `dim_date`       | Date & time attributes             |

### 📈 Fact Tables
| Table                  | Grain                            | Description                         |
|------------------------|----------------------------------|-------------------------------------|
| `fact_sessions`        | 1 row per session                | Streaming behavior & timestamps     |
| `fact_user_subscriptions` | 1 row per user per subscription | Subscription history                |
| `bridge_track_genres`  | 1 row per track per genre        | Genre classification (many-to-many) |

---

## 🔍 Analytical Use Cases

1. **Regional Genre Popularity**
   - Identify most played genres by state using `fact_sessions`, `dim_users`, `dim_genres`.

2. **Artist Popularity by Age**
   - Determine most popular artists across age groups using `dim_users`, `dim_artists`, and `fact_sessions`.

3. **Temporal Listening Behavior**
   - Analyze listening trends by hour using `fact_sessions` and `dim_date`.

---

## 📊 Dashboards (Power BI)

| Dashboard                 | Key Metrics & Questions Answered                            |
|---------------------------|-------------------------------------------------------------|
| Executive Overview        | Engagement trends, top genres, session activity             |
| Users & Subscriptions     | Age distribution, subscription type by region               |
| Artists & Tracks          | Track/artist popularity, genre trends over time             |

---

## ⚙️ Tech Stack

- **Database**: Snowflake
- **ETL/ELT**: SQL-based ELT in Snowflake
- **BI Tool**: Power BI
- **Languages**: SQL (DDL & DML), Python (optional for ingestion)
- **Schema Design**: Normalized + Star Schema with Bus Matrix

---
