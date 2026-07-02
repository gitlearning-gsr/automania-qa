-- ============================================================
-- Automania.qa — Supabase Database Schema + Seed Data
-- Run this in: Supabase Dashboard → SQL Editor → New query
-- ============================================================

-- 1. Create the cars table
CREATE TABLE IF NOT EXISTS cars (
  id          INTEGER PRIMARY KEY,
  brand       TEXT NOT NULL,
  model       TEXT NOT NULL,
  type        TEXT NOT NULL,
  badge       TEXT,
  price       INTEGER NOT NULL,
  featured    BOOLEAN DEFAULT false,
  upcoming    BOOLEAN DEFAULT false,
  wiki        TEXT,
  img         TEXT,
  pdf         TEXT DEFAULT '',
  specs       JSONB,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Row Level Security — allow public reads
ALTER TABLE cars ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies WHERE tablename='cars' AND policyname='Public read access'
  ) THEN
    CREATE POLICY "Public read access" ON cars FOR SELECT USING (true);
  END IF;
END $$;

-- 3. Indexes for fast filtering
CREATE INDEX IF NOT EXISTS cars_brand_idx ON cars(brand);
CREATE INDEX IF NOT EXISTS cars_type_idx  ON cars(type);
CREATE INDEX IF NOT EXISTS cars_price_idx ON cars(price);

-- 4. Seed all 65 cars
INSERT INTO cars (id, brand, model, type, badge, price, featured, upcoming, wiki, img, pdf, specs)
VALUES
  (1, 'Toyota', 'Land Cruiser 300', 'suv', 'Hybrid', 280000, true, false, 'Toyota Land Cruiser 300', 'https://tmna.aemassets.toyota.com/is/image/toyota/toyota/jellies/relative/2027/landcruiser/base.png?wid=1140&hei=600&fmt=jpg&fit=crop', 'Toyota_Qatar/Land_Cruiser_Brochure.pdf', '{"Engine": "3.5L V6 Twin-Turbo", "Power": "415 hp", "Torque": "650 Nm", "Trans": "10-speed Auto", "Drive": "4WD", "Seats": "7", "Fuel": "Hybrid"}'),
  (2, 'Nissan', 'Patrol 2025', 'suv', NULL, 235000, true, false, 'Nissan Patrol', 'https://www.nissan-me.com/content/dam/Nissan/me/home-page/new_patrol/NissanPatrol2025_main.jpg', 'Nissan/Nissan_Patrol_Catalogue.pdf', '{"Engine": "5.6L V8", "Power": "400 hp", "Torque": "560 Nm", "Trans": "7-speed Auto", "Drive": "4WD", "Seats": "8", "Fuel": "Petrol"}'),
  (3, 'Kia', 'EV9', 'ev', 'EV', 240000, true, false, 'Kia Telluride', 'https://www.kia.com/content/dam/kwsovp/us/en/kia/ev9/2024/imagery/exterior/kia-ev9-2024-gallery-exterior-01-full.jpg', 'Kia_Qatar/Kia_EV9_Brochure.pdf', '{"Battery": "99.8 kWh", "Range": "541 km", "Power": "379 hp", "Charge_DC": "240 kW", "Drive": "AWD", "Seats": "7"}'),
  (4, 'Lexus', 'LX 600', 'luxury', NULL, 420000, true, false, 'Hyundai Tucson', 'https://www.lexus.com/content/dam/lexus/images/models/lx/2024/lexus-lx-600-overview.jpg', 'Lexus/Lexus_LX_2025_Brochure.pdf', '{"Engine": "3.5L V6 Twin-Turbo", "Power": "415 hp", "Torque": "650 Nm", "Trans": "10-speed Auto", "Drive": "4WD", "Seats": "7", "Fuel": "Petrol"}'),
  (5, 'Toyota', 'Hilux 2025', 'pickup', NULL, 112000, true, false, 'BYD Atto 3', 'https://global.toyota/pages/models/images/hilux/hilux_kv_w1920_02.jpg', 'Toyota_Qatar_Brochures/Toyota_Hilux_Brochure.pdf', '{"Engine": "2.8L Turbo Diesel", "Power": "204 hp", "Torque": "500 Nm", "Trans": "6-speed Auto", "Drive": "4WD", "Seats": "5", "Fuel": "Diesel"}'),
  (6, 'Toyota', 'Land Cruiser 70 (2025)', 'suv', NULL, 185000, false, true, 'Kia EV6', 'https://global.toyota/pages/models/images/landcruiser70/landcruiser70_kv_w1920.jpg', '', '{"Engine": "2.8L Turbo Diesel", "Power": "204 hp", "Torque": "500 Nm", "Trans": "6-speed Manual", "Drive": "4WD", "Seats": "5", "Fuel": "Diesel"}'),
  (7, 'Kia', 'EV3 2025', 'ev', 'EV', 135000, false, true, 'Hyundai IONIQ 5', 'https://www.kia.com/content/dam/kwsovp/int/models/ev3/2024/imagery/kia-ev3-2024-exterior-01.jpg', '', '{"Battery": "81.4 kWh", "Range": "600 km", "Power": "204 hp", "Charge_DC": "135 kW", "Drive": "FWD", "Seats": "5"}'),
  (8, 'Hyundai', 'IONIQ 9 2025', 'ev', 'EV', 260000, false, true, 'Toyota bZ4X', 'https://www.hyundainews.com/assets/images/original/2024/10/22/185456-HyundaiMotorRevealseIONIQ9.jpg', '', '{"Battery": "110 kWh", "Range": "620 km", "Power": "422 hp", "Charge_DC": "350 kW", "Drive": "AWD", "Seats": "7"}'),
  (9, 'Nissan', 'Patrol Nismo 2025', 'suv', NULL, 295000, false, true, 'BYD Seal', 'https://www.nissan-arabianpeninsula.com/content/dam/Nissan/na-common/new-patrol/nismo/patrol-nismo-hero.jpg', '', '{"Engine": "5.6L V8 NISMO Tuned", "Power": "428 hp", "Torque": "570 Nm", "Trans": "7-speed Auto", "Drive": "4WD", "Seats": "8", "Fuel": "Petrol"}'),
  (10, 'BYD', 'Seagull 2025', 'ev', 'EV', 72000, false, true, 'Geely Galaxy E8', 'https://ev.byd.com/eu/content/dam/byd-eu/images/Seagull/seagull-overview-hero.jpg', '', '{"Battery": "38.9 kWh", "Range": "405 km", "Power": "74 hp", "Charge_DC": "40 kW", "Drive": "FWD", "Seats": "5"}'),
  (11, 'Toyota', 'Prado Hybrid 2024', 'suv', 'Hybrid', 195000, false, false, 'Toyota Camry', 'https://global.toyota/pages/models/images/landcruiserprado/landcruiserprado_kv_w1920.jpg', 'Toyota_Qatar/Prado 2024 - Digital CLK copy.pdf', '{"Engine": "2.4L Turbo Hybrid", "Power": "326 hp", "Torque": "630 Nm", "Trans": "8-speed Auto", "Drive": "4WD", "Seats": "7", "Fuel": "Hybrid"}'),
  (12, 'Toyota', 'Camry Hybrid', 'sedan', 'Hybrid', 95000, false, false, 'Honda Accord', 'https://tmna.aemassets.toyota.com/is/image/toyota/toyota/jellies/relative/2026/camry/base.png?wid=1140&hei=600&fmt=jpg&fit=crop', 'Toyota_Qatar_Brochures/Toyota_Camry_Brochure.pdf', '{"Engine": "2.5L Hybrid", "Power": "218 hp", "Trans": "e-CVT", "Drive": "FWD", "Seats": "5", "Fuel": "Hybrid"}'),
  (13, 'Honda', 'CR-V e:HEV', 'suv', 'Hybrid', 120000, false, false, 'Toyota RAV4', 'https://automobiles.honda.com/-/media/Honda-Automobiles/Vehicles/2026/CR-V/nonVLP/Global-Nav/MY26_CR-V_Hybrid_BAP_Jelly.png?sc_lang=en', 'Honda_Qatar/Honda_CRV_Brochure.pdf', '{"Engine": "2.0L i-MMD Hybrid", "Power": "204 hp", "Trans": "e-CVT", "Drive": "AWD", "Seats": "5", "Fuel": "Hybrid"}'),
  (14, 'Hyundai', 'Santa Fe Hybrid', 'suv', 'Hybrid', 155000, false, false, 'Kia Sportage', 'https://www.hyundai.com/content/dam/hyundai/master/en/data/find-a-car/suv/santa-fe/inquiry/pc/santa-fe-overview-exterior-pc.jpg', 'Hyundai_Qatar/Hyundai_SantaFe_Brochure.pdf', '{"Engine": "1.6L Turbo Hybrid", "Power": "230 hp", "Trans": "6-speed Auto", "Drive": "AWD", "Seats": "7", "Fuel": "Hybrid"}'),
  (15, 'BYD', 'Shark 6 PHEV', 'pickup', 'PHEV', 155000, false, false, 'Hyundai Santa Fe', 'https://ev.byd.com/eu/content/dam/byd-eu/images/shark/byd-shark-overview.jpg', 'BYD/BYD_SHARK6_DMO_Brochure.pdf', '{"Engine": "2.0T + Dual Motor", "Power": "665 hp", "Torque": "800 Nm", "Drive": "4WD", "Seats": "5", "Fuel": "PHEV", "EV_Range": "100 km"}'),
  (16, 'BYD', 'ATTO 3', 'ev', 'EV', 130000, false, false, 'GMC Yukon', 'https://ev.byd.com/eu/content/dam/byd-eu/images/atto3/atto3-overview-exterior.jpg', 'BYD/BYD_ATTO3_Brochure.pdf', '{"Battery": "60.5 kWh", "Range": "400 km", "Power": "204 hp", "Charge_DC": "80 kW", "Drive": "FWD", "Seats": "5"}'),
  (17, 'BYD', 'SEAL', 'ev', 'EV', 145000, false, false, 'Toyota Fortuner', 'https://ev.byd.com/eu/content/dam/byd-eu/images/seal/seal-overview-exterior.jpg', 'BYD/BYD_SEAL_Brochure.pdf', '{"Battery": "82.5 kWh", "Range": "520 km", "Power": "523 hp", "Charge_DC": "150 kW", "Drive": "AWD", "Seats": "5"}'),
  (18, 'Hyundai', 'IONIQ 5', 'ev', 'EV', 175000, false, false, 'Nissan Navara', 'https://www.hyundai.com/content/dam/hyundai/master/en/data/find-a-car/passenger-car/ioniq5/inquiry/pc/ioniq5-overview-exterior-pc.jpg', 'Hyundai_Qatar/Hyundai_Ioniq5_Brochure.pdf', '{"Battery": "77.4 kWh", "Range": "481 km", "Power": "325 hp", "Charge_DC": "230 kW", "Drive": "AWD", "Seats": "5"}'),
  (19, 'Hyundai', 'IONIQ 6', 'ev', 'EV', 185000, false, false, 'Mazda CX-60', 'https://www.hyundai.com/content/dam/hyundai/master/en/data/find-a-car/passenger-car/ioniq6/inquiry/pc/ioniq6-overview-exterior-pc.jpg', 'Hyundai_Qatar/Hyundai_Ioniq6_Brochure.pdf', '{"Battery": "77.4 kWh", "Range": "614 km", "Power": "325 hp", "Charge_DC": "230 kW", "Drive": "AWD", "Seats": "5"}'),
  (20, 'Kia', 'EV6', 'ev', 'EV', 180000, false, false, 'Infiniti QX80', 'https://www.kia.com/content/dam/kwsovp/us/en/kia/ev6/2024/imagery/exterior/kia-ev6-2024-gallery-exterior-01-full.jpg', 'Kia_Qatar/Kia_EV6_Brochure.pdf', '{"Battery": "77.4 kWh", "Range": "528 km", "Power": "577 hp", "Charge_DC": "240 kW", "Drive": "AWD", "Seats": "5"}'),
  (21, 'Land Rover', 'Range Rover', 'luxury', NULL, 520000, false, false, 'Suzuki Vitara', 'https://www.rangerover.com/content/dam/lrdx/global/l460/27my/int/L46027GL_303105263_WESTMINSTER_011_DX_ALT.jpg', 'LandRover/LandRover_RangeRover_Brochure.pdf', '{"Engine": "4.4L V8", "Power": "530 hp", "Torque": "750 Nm", "Trans": "8-speed Auto", "Drive": "AWD", "Seats": "5", "Fuel": "Petrol"}'),
  (22, 'Land Rover', 'Defender 110', 'luxury', NULL, 295000, false, false, NULL, 'https://jlr.scene7.com/is/image/jlr/L66326GL_303104383_060_DX', 'LandRover/LandRover_Defender_2024_SpecGuide.pdf', '{"Engine": "3.0L Mild Hybrid", "Power": "400 hp", "Trans": "8-speed Auto", "Drive": "4WD", "Seats": "7", "Fuel": "Petrol"}'),
  (23, 'GMC', 'Yukon Denali', 'luxury', NULL, 310000, false, false, NULL, 'https://www.gmc.com/content/dam/gmc/na/us/english/index/vehicles/2026/suvs/yukon/overview/gallery/my26-yukon-mov-safety-gallery-preview4-2500x1248-25PGYK00037.jpg', 'GMC/GMC_Yukon_2024_Brochure.pdf', '{"Engine": "6.2L V8", "Power": "420 hp", "Torque": "624 Nm", "Trans": "10-speed Auto", "Drive": "4WD", "Seats": "8", "Fuel": "Petrol"}'),
  (24, 'Infiniti', 'QX80 2025', 'luxury', NULL, 295000, false, false, NULL, 'https://www.infiniti-cdn.net/content/dam/Infiniti/entryway/vehicles/qx80/2026/overview/2026-infiniti-qx80-hero-video-d.jpg', 'Infiniti/Infiniti_QX80_MY25_Brochure.pdf', '{"Engine": "3.5L V6 Hybrid", "Power": "400 hp", "Trans": "7-speed Auto", "Drive": "4WD", "Seats": "8", "Fuel": "Petrol"}'),
  (25, 'Porsche', 'Cayenne PHEV', 'luxury', 'PHEV', 450000, false, false, NULL, 'https://images.porsche.com/f/285489813253582/5000x1795/94e6583a68/model-9yaai1-side-shot_4d0897f6999243f281be5868f6992c04.png', 'https://autocatalogarchive.com/wp-content/uploads/2022/10/Porsche-Cayenne-2021-INT.pdf', '{"Engine": "4.0L V8 + Motor", "Power": "739 hp", "Torque": "1000 Nm", "Drive": "AWD", "Seats": "5", "Fuel": "PHEV", "EV_Range": "42 km"}'),
  (26, 'BYD', 'HAN EV', 'chinese', 'EV', 160000, false, false, 'Toyota Land Cruiser 70 Series', 'https://ev.byd.com/eu/content/dam/byd-eu/images/han/han-ev-overview-exterior.jpg', 'BYD/BYD_HAN-EV_Brochure.pdf', '{"Battery": "85.4 kWh", "Range": "521 km", "Power": "517 hp", "Charge_DC": "120 kW", "Drive": "AWD", "Seats": "5"}'),
  (27, 'Geely', 'Monjaro', 'chinese', NULL, 125000, false, false, 'Land Rover Defender', 'https://www.geely.com/content/dam/geely-auto/models/monjaro/monjaro-hero.jpg', 'Geely/Geely_Monjaro.pdf', '{"Engine": "2.0T Turbo", "Power": "238 hp", "Trans": "7-speed DCT", "Drive": "AWD", "Seats": "5", "Fuel": "Petrol"}'),
  (28, 'Jetour', 'Traveller 8', 'chinese', NULL, 155000, false, false, 'BMW X7', 'https://www.jetourglobal.com/content/dam/jetour/models/traveller/traveller-overview-hero.jpg', '', '{"Engine": "2.0T Turbo", "Power": "261 hp", "Trans": "8-speed Auto", "Drive": "4WD", "Seats": "8", "Fuel": "Petrol"}'),
  (29, 'Zeekr', '001', 'chinese', 'EV', 195000, false, false, 'Mercedes-Benz GLS-Class', 'https://www.zeekrlife.com/media/001/zeekr-001-exterior-front.jpg', 'Zeekr/Zeekr_001.pdf', '{"Battery": "100 kWh", "Range": "620 km", "Power": "544 hp", "Charge_DC": "200 kW", "Drive": "AWD", "Seats": "4"}'),
  (30, 'LiAuto', 'L9', 'chinese', 'PHEV', 210000, false, false, 'Porsche Cayenne', 'https://www.lixiang.com/imgs/models/l9/l9-overview-exterior.jpg', 'LiAuto/LiAuto_L9.pdf', '{"Engine": "1.5T + Dual Motor", "Power": "449 hp", "Drive": "AWD", "Seats": "6", "Fuel": "PHEV", "EV_Range": "215 km"}'),
  (31, 'Ford', 'Ranger Raptor', 'pickup', NULL, 148000, false, false, 'Ford Ranger', 'https://www.ford.com/acslibs/content/dam/na/ford/en_us/images/ranger/2025/general/Social_Lifestyle_Storytelling-Ranger_Raptor_9_fade.jpg', 'Ford/Ford_Ranger_MY25_Spec.pdf', '{"Engine": "3.0L V6 Twin-Turbo", "Power": "288 hp", "Torque": "583 Nm", "Trans": "10-speed Auto", "Drive": "4WD", "Seats": "5", "Fuel": "Diesel"}'),
  (32, 'Ford', 'Mustang GT', 'sports', NULL, 185000, false, false, 'Ford Mustang', 'https://www.ford.com/acslibs/content/dam/na/ford/en_us/images/mustang/2026/general/ford-mustang-gt-2026-hero.jpg', 'Ford/Ford_Mustang_MY26_Spec.pdf', '{"Engine": "5.0L V8 Coyote", "Power": "486 hp", "100": "4.3 s", "Trans": "10-speed Auto", "Drive": "RWD", "Seats": "4", "Fuel": "Petrol"}'),
  (33, 'Honda', 'Accord e:HEV', 'sedan', 'Hybrid', 105000, false, false, 'Honda Accord', 'https://automobiles.honda.com/-/media/Honda-Automobiles/Vehicles/2026/accord-sedan/Non-VLP/NAV/MY26_ACCORD_Global-Nav_Jelly.png?sc_lang=en', 'Honda_Qatar/Honda_Accord_HEV_Brochure.pdf', '{"Engine": "2.0L i-MMD", "Power": "204 hp", "Trans": "e-CVT", "Drive": "FWD", "Seats": "5", "Fuel": "Hybrid"}'),
  (34, 'Kia', 'Sorento', 'suv', NULL, 145000, false, false, 'Kia Sorento', 'https://www.kia.com/content/dam/kwsovp/us/en/kia/sorento/2024/imagery/exterior/kia-sorento-2024-gallery-exterior-01-full.jpg', 'Kia_Qatar/Kia_Sorento_Brochure.pdf', '{"Engine": "2.5L Turbo", "Power": "281 hp", "Trans": "8-speed DCT", "Drive": "AWD", "Seats": "7", "Fuel": "Petrol"}'),
  (35, 'Toyota', 'Granvia', 'mpv', NULL, 165000, false, false, 'Toyota HiAce', 'https://global.toyota/pages/models/images/granvia/granvia_kv_w1920.jpg', 'Toyota_Qatar_Brochures/Toyota_Granvia_Brochure.pdf', '{"Engine": "2.8L Turbo Diesel", "Power": "177 hp", "Trans": "6-speed Auto", "Drive": "RWD", "Seats": "12", "Fuel": "Diesel"}'),
  (36, 'Lexus', 'GX 550', 'luxury', NULL, 320000, false, false, 'Lexus GX', 'https://www.lexus.com/content/dam/lexus/images/models/gx/2024/lexus-gx-550-overview-hero.jpg', 'Lexus/Lexus_GX_2025_Brochure.pdf', '{"Engine": "3.4L V6 Twin-Turbo", "Power": "349 hp", "Trans": "10-speed Auto", "Drive": "4WD", "Seats": "7", "Fuel": "Petrol"}'),
  (37, 'Isuzu', 'D-Max', 'pickup', NULL, 95000, false, false, 'Isuzu D-Max', 'https://www.isuzu-global.com/product/dmax/images/dmax-hero.jpg', 'Isuzu/Isuzu_Dmax_Catalogue.pdf', '{"Engine": "1.9L Turbo Diesel", "Power": "163 hp", "Trans": "6-speed Auto", "Drive": "4WD", "Seats": "5", "Fuel": "Diesel"}'),
  (38, 'Mitsubishi', 'Outlander PHEV', 'suv', 'PHEV', 135000, false, false, 'Mitsubishi Outlander PHEV', 'https://www.mitsubishi-motors.com/content/dam/com/motorshowroom/en/outlander_phev/exterior-front.jpg', 'Mitsubishi/Mitsubishi_Outlander.pdf', '{"Engine": "2.4L + Twin Motor", "Power": "248 hp", "Drive": "4WD", "Seats": "7", "Fuel": "PHEV", "EV_Range": "87 km"}'),
  (39, 'Jetour', 'T2', 'chinese', NULL, 146000, false, false, 'Jetour T2', 'https://www.jetourglobal.com/content/dam/jetour/models/t2/t2-overview-hero.jpg', 'Jetour/jetour-t2-2025my.pdf', '{"Engine": "2.0T Turbo", "Power": "254 hp", "Torque": "390 Nm", "Trans": "7-speed DCT", "Drive": "4WD", "Seats": "5", "Fuel": "Petrol"}'),
  (40, 'Jetour', 'G700', 'chinese', NULL, 185000, false, false, NULL, 'https://jetourglobal.com/new-static/images/vehicles/cars/g700/p1_1.png', 'Jetour/jetour-g700-v2-brochure.pdf', '{"Engine": "2.0T Turbo", "Power": "254 hp", "Torque": "390 Nm", "Trans": "9-speed Auto", "Drive": "AWD", "Seats": "7", "Fuel": "Petrol"}'),
  (41, 'Jetour', 'Dashing', 'chinese', NULL, 89000, false, false, NULL, 'https://jetourglobal.com/new-static/images/vehicles/image/dashing.png', 'Jetour/2024-Dashing-Brochure.pdf', '{"Engine": "1.6T Turbo", "Power": "197 hp", "Torque": "290 Nm", "Trans": "7-speed DCT", "Drive": "FWD", "Seats": "5", "Fuel": "Petrol"}'),
  (42, 'Jetour', 'Traveller 8', 'chinese', NULL, 210000, false, true, NULL, 'https://carnewschina.com/wp-content/uploads/2026/04/img_20260424_120528-1-1500x844.jpg', '', '{"Engine": "2.4T Turbo", "Power": "270 hp", "Trans": "9-speed Auto", "Drive": "4WD", "Seats": "8", "Fuel": "Petrol", "Body": "Full-size MPV"}'),
  (43, 'iCar', 'V23', 'chinese', 'EV', 54964, false, false, NULL, 'https://www.icaur.com.my/_next/static/media/v23_front.414714b4.webp', 'https://autocatalogarchive.com/wp-content/uploads/2025/12/iCAUR-V23-2026-MY.pdf', '{"Motor": "Single/Dual", "Power": "211 hp (AWD)", "Range": "501 km", "Battery": "64.7 kWh", "Drive": "AWD", "Seats": "5", "Design": "Retro Boxy EV"}'),
  (44, 'GWM', 'Tank 300', 'chinese', NULL, 168000, false, false, 'GWM Tank 300', 'https://www.gwm-global.com/content/dam/gwm/models/tank300/tank300-exterior-front.jpg', 'GWM/Brochure_tank300.pdf', '{"Engine": "2.0T Turbo", "Power": "227 hp", "Torque": "387 Nm", "Trans": "8-speed Auto", "Drive": "4WD", "Seats": "5", "Fuel": "Petrol", "Type": "Off-Road Ladder Frame"}'),
  (45, 'GWM', 'Tank 500 Hi4-T', 'chinese', 'Hybrid', 248000, false, false, 'GWM Tank 500', 'https://www.gwm-global.com/content/dam/gwm/models/tank500/tank500-exterior-front.jpg', 'GWM/Brochure_tank500hybrid.pdf', '{"Engine": "2.0T + Electric", "Power": "340 hp System", "Torque": "750 Nm", "Trans": "9-speed Auto", "Drive": "4WD", "Seats": "7", "Fuel": "PHEV", "EV_Range": "100 km"}'),
  (46, 'Denza', 'D9', 'chinese', 'EV', 265000, false, false, NULL, 'https://media.byd.com/wp-content/uploads/2026/04/b2f42a83c2a8a8872e0183b47583ef3a-l.jpg', 'Denza/Denza_B8_Flagship_6-Seater.pdf', '{"Motor": "Dual", "Power": "536 hp", "Range": "620 km", "Battery": "103 kWh", "Drive": "AWD", "Seats": "7", "Body": "Premium MPV"}'),
  (47, 'Denza', 'B5', 'chinese', 'EV', 175000, false, false, NULL, 'https://www.denza.com/material/denza-site/au/home/site-updates-2-december/B5-heroweb.webp', 'Denza/Denza_B5_Deluxe.pdf', '{"Motor": "Single/Dual", "Power": "402 hp (AWD)", "Range": "526 km", "Battery": "82 kWh", "Drive": "FWD/AWD", "Seats": "5", "Body": "Electric SUV"}'),
  (48, 'Denza', 'B8', 'chinese', 'EV', 235000, false, false, NULL, 'https://www.denza.com/material/denza-site/au/home/site-updates-2-december/B8ReserveNowDesktop.webp', 'Denza/Denza_B8_Flagship_6-Seater.pdf', '{"Motor": "Dual", "Power": "536 hp", "Range": "520 km", "Battery": "103 kWh", "Drive": "AWD", "Seats": "6/7", "Body": "Large Electric SUV"}'),
  (49, 'Deepal', 'S07', 'chinese', 'EV', 135000, false, false, NULL, 'https://i0.wp.com/changanuk.media/wp-content/uploads/2025/09/S07-19-1.jpg', 'Deepal/Deepal_S07.pdf', '{"Motor": "Single", "Power": "218 hp", "Range": "520 km", "Battery": "66.7 kWh", "Drive": "RWD", "Seats": "5", "Body": "Electric Crossover"}'),
  (50, 'Deepal', 'G318', 'chinese', 'EV', 168000, false, false, NULL, 'https://www.deepal-eg.com/media/products/G318_Exterior_1920_x_1113_g318.png', 'Deepal/Deepal_G318.pdf', '{"Motor": "Dual", "Power": "402 hp", "Range": "460 km", "Battery": "82 kWh", "Drive": "AWD", "Seats": "5", "Body": "Adventure EV SUV"}'),
  (51, 'MG', 'MG4 EV', 'chinese', 'EV', 89000, false, false, 'MG4 EV', 'https://www.mgmotor.co.uk/content/dam/mg/mg4/mg4-electric-gallery-hero.jpg', 'MG/MG_4_EV.pdf', '{"Motor": "Single", "Power": "204 hp", "Range": "435 km", "Battery": "64 kWh", "Drive": "RWD", "Seats": "5", "Body": "Compact Electric Hatch"}'),
  (52, 'MG', 'MG7', 'chinese', NULL, 98000, false, false, NULL, 'https://media-hub-prod.mgmotor.me/api/v2/images/422/w/896/h/504.jpg', 'MG/MG_7.pdf', '{"Engine": "2.0T Turbo", "Power": "258 hp", "Torque": "405 Nm", "Trans": "8-speed Auto", "Drive": "FWD", "Seats": "5", "Body": "Sport Sedan"}'),
  (53, 'Hongqi', 'H9', 'chinese', NULL, 295000, false, false, NULL, 'https://www.hongqi-auto.com/storage/faw/20250822_h9.webp', 'Hongqi/Hongqi_H9.pdf', '{"Engine": "2.0T Turbo", "Power": "252 hp", "Trans": "8-speed Auto", "Drive": "RWD/AWD", "Seats": "5", "Fuel": "Petrol", "Body": "Luxury Flagship Sedan"}'),
  (54, 'Hongqi', 'HS7', 'chinese', NULL, 245000, false, false, NULL, 'https://www.hongqi-auto.com/images/cartype/hs7_2025/kv.jpg', 'Hongqi/Hongqi_HS7.pdf', '{"Engine": "2.0T Turbo", "Power": "252 hp", "Trans": "8-speed Auto", "Drive": "AWD", "Seats": "7", "Fuel": "Petrol", "Body": "Luxury Large SUV"}'),
  (55, 'BAIC', 'BJ40 SE', 'chinese', NULL, 128000, false, false, NULL, 'https://www.baicglobal.com/file/common/image/2024/12/16/DM_20241216155313_001_20241216160344A663.png', 'BAIC/BAIC_BJ40SE.pdf', '{"Engine": "2.3T Turbo", "Power": "224 hp", "Torque": "340 Nm", "Trans": "8-speed Auto", "Drive": "4WD", "Seats": "5", "Fuel": "Petrol", "Type": "Off-Road"}'),
  (56, 'Maxus', 'D90 Pro', 'chinese', NULL, 155000, false, false, NULL, 'https://maxus.sa/wp-content/uploads/2025/07/Maxus-D90-Pro.jpg', 'Maxus/Maxus_D90.pdf', '{"Engine": "2.0T Turbo", "Power": "224 hp", "Torque": "360 Nm", "Trans": "6-speed Auto", "Drive": "4WD", "Seats": "7", "Fuel": "Petrol", "Body": "Flagship MPV"}'),
  (57, 'Zeekr', '7X', 'chinese', 'EV', 195000, false, false, 'Zeekr 7X', 'https://www.zeekrlife.com/media/7x/zeekr-7x-exterior-front.jpg', 'Zeekr/Zeekr_7X.pdf', '{"Motor": "Dual", "Power": "544 hp", "100": "3.8 s", "Range": "605 km", "Battery": "100 kWh", "Drive": "AWD", "Seats": "5", "Body": "Performance Electric SUV"}'),
  (58, 'Xpeng', 'G9', 'chinese', 'EV', 215000, false, false, 'Xpeng G9', 'https://www.xpeng.com/content/dam/xpeng/models/g9/xpeng-g9-overview-hero.jpg', 'Xpeng/Xpeng_G9.pdf', '{"Motor": "Dual", "Power": "551 hp", "100": "3.9 s", "Range": "520 km", "Battery": "98 kWh", "Drive": "AWD", "Seats": "6", "Body": "Premium Electric SUV"}'),
  (59, 'LiAuto', 'L9', 'chinese', 'PHEV', 335000, false, false, NULL, 'https://carnewschina.com/wp-content/uploads/2026/05/e59bbee78987-55-e1778836967641-800x451.png', 'LiAuto/Li_Auto_L9.pdf', '{"Engine": "1.5T + Electric", "Power": "449 hp System", "Range": "1315 km", "EV_Range": "215 km", "Drive": "AWD", "Seats": "6", "Body": "6-Seat Flagship SUV"}'),
  (60, 'Slate', 'Truck', 'ev', 'EV', 24950, false, true, 'Slate Auto Truck', 'https://static.slateauto.com/media/slate-truck-hero.jpg', '', '{"Motor": "Single RWD", "Power": "181 hp", "Range": "240 km", "Battery": "65 kWh LFP", "Drive": "RWD", "Seats": "2", "Body": "Compact EV Pickup", "Origin": "USA 2026"}'),
  (61, 'Rivian', 'R2', 'ev', 'EV', 45000, false, true, 'Rivian R2', 'https://res.cloudinary.com/rivian-main/image/upload/f_auto/q_auto/v1/gold-iris/metadata/R2?_a=BAVHt2DY0', '', '{"Motor": "Dual AWD", "Power": "~350 hp", "Range": "530 km", "Battery": "75 kWh", "Drive": "AWD", "Seats": "5", "Body": "Compact Adventure SUV", "Origin": "USA 2026"}'),
  (62, 'Scout', 'Terra', 'pickup', 'EV', 218000, false, true, NULL, 'https://blog.scoutmotors.com/wp-content/uploads/2025/01/Scout-Terra_Exterior-MJR_1022-sm.jpg', '', '{"Motor": "Dual AWD", "Power": "~400 hp", "Range": "480 km", "Drive": "AWD", "Seats": "5", "Body": "Rugged EV Pickup", "Origin": "USA/VW 2026"}'),
  (63, 'Hyundai', 'IONIQ 9', 'suv', 'EV', 285000, false, true, 'Hyundai IONIQ 9', 'https://www.hyundainews.com/assets/images/original/2024/10/22/185456-HyundaiMotorRevealseIONIQ9.jpg', '', '{"Motor": "Dual AWD", "Power": "422 hp", "100": "5.0 s", "Range": "620 km", "Battery": "110.3 kWh", "Drive": "AWD", "Seats": "7/8", "Body": "Full-size Electric SUV"}'),
  (64, 'Kia', 'EV3', 'suv', 'EV', 105000, false, true, 'Kia EV3', 'https://www.kia.com/content/dam/kwsovp/int/models/ev3/2024/imagery/kia-ev3-2024-exterior-01.jpg', '', '{"Motor": "Single", "Power": "201 hp", "Range": "600 km", "Battery": "81.4 kWh", "Drive": "FWD", "Seats": "5", "Body": "Compact Electric SUV", "Origin": "Global 2025"}'),
  (65, 'Toyota', 'C-HR EV', 'suv', 'EV', 138000, false, true, NULL, 'https://global.toyota/pages/news/images/2025/03/12/0801/001.jpg', '', '{"Motor": "Single/Dual", "Power": "168/196 hp", "Range": "400 km", "Battery": "54 kWh", "Drive": "FWD/AWD", "Seats": "5", "Body": "Crossover EV"}')
ON CONFLICT (id) DO UPDATE SET
  brand    = EXCLUDED.brand,
  model    = EXCLUDED.model,
  type     = EXCLUDED.type,
  badge    = EXCLUDED.badge,
  price    = EXCLUDED.price,
  featured = EXCLUDED.featured,
  upcoming = EXCLUDED.upcoming,
  wiki     = EXCLUDED.wiki,
  img      = EXCLUDED.img,
  pdf      = EXCLUDED.pdf,
  specs    = EXCLUDED.specs;

-- 5. Verify
SELECT COUNT(*) AS total_cars FROM cars;
