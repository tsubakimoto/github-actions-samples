# ガイドライン

## 全般

- `.github/copilot-instructions.md` : Copilot の振る舞い

## サブエージェント

```
.github/
└── agents/
    ├── orchestrator.agent.md  # オーケストレーター
    ├── issue.agent.md         # Issue 作成/管理
    ├── plan.agent.md          # 実装計画の策定
    ├── impl.agent.md          # TDD に基づく実装
    ├── review.agent.md        # コードレビュー
    └── pr.agent.md            # PR 作成
```

## リポジトリ構成

| Area | Location | Description |
| --- | --- | --- |
| act | `act/` | nektos/act 関連のファイル |
| Bicep | `bicep/` | Bicep テンプレート |
| Container | `container/` | コンテナ関連 |
| Nginx container | `container/nginx` | Nginx コンテナ関連 |
| dotnet | `dotnet/` | .NET 関連 |
| .NET 6.0 | `dotnet/net6.0/` | .NET 6.0 関連 |
| .NET 7.0 | `dotnet/net7.0/` | .NET 7.0 関連 |
| .NET 8.0 | `dotnet/net8.0/` | .NET 8.0 関連 |
| .NET 9.0 | `dotnet/net9.0/` | .NET 9.0 関連 |
| .NET 10.0 | `dotnet/net10.0/` | .NET 10.0 関連 |
| .NET Standard 2.0 | `dotnet/netStandard2.0/` | .NET Standard 2.0 関連 |
| HTML | `html/` | HTML サンプル |
| Node.js | `nodejs/` | Node.js サンプル |
| Express | `nodejs/express/` | Express サンプル |
| Nuxt.js | `nodejs/nuxtjs/` | Nuxt.js サンプル |
| PHP | `php/` | PHP サンプル |
| CakePHP 5 | `php/cakephp5/` | CakePHP 5 サンプル |
| Laravel | `php/laravel/` | Laravel サンプル |
| Simple | `php/simple/` | Simple PHP サンプル |
| Playwright | `playwright/` | Playwright サンプル |
| Python | `python/` | Python サンプル |
| Django | `python/django/` | Django サンプル |
| FastAPI | `python/fastapi/` | FastAPI サンプル |
| sqlscripts | `sqlscripts/` | SQL スクリプト |

