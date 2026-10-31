---
name: skill-search
description: Find and compare existing GitHub Actions workflows in this repository from a user's intended use case. Use when someone describes what they want to automate and asks which workflow example applies.
---

# Workflow Use-Case Search

ユーザーが実現したい用途から、このリポジトリにある既存の GitHub Actions ワークフローを探し、適合する例とその違いを説明します。ワークフローの新規作成や変更は行いません。

## 手順

1. ユーザーの目的、対象サービスや技術、必要な処理を読み取ります。トリガー、入力、認証方式、成果物、デプロイ先などが用途に関係する場合は、それらも検索条件に含めます。
2. `README.md` の「GitHub Actions ワークフロー」を索引として確認し、候補を絞ります。
3. `.github/workflows/` 配下の候補となる YAML 定義を読み、`name`、`on`、`jobs`、`steps`、`with`、`env`、`permissions` を確認します。README の説明だけで適合を判断せず、ワークフロー定義を根拠にします。
4. ユーザーの目的に対する動作の一致度で候補を比較します。ファイル名の類似より、実際に行う処理と前提条件を優先します。
5. 最も適合するワークフローを先に示し、必要な場合は類似候補との違いも説明します。判断に必要な情報が不足し、候補が変わり得る場合は、検索を進める前に具体的な条件を一つ確認します。

## 回答

- 日本語で簡潔に回答します。
- 各候補について、ワークフロー名、ファイルパス、用途に合う理由を示します。必要に応じてトリガー、必須入力、Secrets/Variables、権限、デプロイ先などの前提条件や類似候補との違いも記載します。
- 定義ファイルにない挙動や前提条件は推測せず、明記されていないことを伝えます。
- 適合する例が見つからない場合は、その旨と確認した範囲を伝えます。新しいワークフローの設計・提案には進みません。

## 範囲

- 対象はこのリポジトリの既存 `.github/workflows/` のみです。
- ワークフローファイルや README は変更せず、ワークフローを実行もしません。
