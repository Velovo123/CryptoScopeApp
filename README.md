# CryptoScope

A native iOS crypto tracker app built with SwiftUI.

## Features
- Browse live cryptocurrency prices
- Search and filter coins
- View detailed price charts with multiple time ranges (1D, 7D, 30D, 90D)
- Add coins to your Watchlist
- Track your Portfolio with profit/loss calculations
- Multi-currency support (USD, EUR, GBP, JPY)

## Data
Real market data is fetched from the [CoinGecko API](https://www.coingecko.com/en/api) (free tier, no API key required).

The app also includes a full **mock data layer** for development and testing — no network required. Toggle in `AppConfig.swift`:

```swift
static let useMockData = false
```

## 📱 App Showcase

<div align="center">

[![App Demo](https://img.youtube.com/vi/xFj2Z1fwibc/maxresdefault.jpg)](https://www.youtube.com/shorts/xFj2Z1fwibc)

*Tap to watch the demo*

</div>
