## checkout-strategy による挙動の違い

`merge` 指定時は、Plan・Apply実行時に（内部的に）mainブランチの内容を取り込んでから実行してくれる。<br>
※ あくまで「内部的に」取り込むだけなので、Atlantisは実際にはこのマージをどこにもコミットしない。単にローカルで使用するだけ。

たとえば、実行PRが最新のmainブランチの変更（SNSのTopic名を`topic-test-2`→`topic-test-1`に変更）を取り込んでいない場合、Plan・Apply実行による差分は以下のようになる。

### branch時（デフォルト）

<details><summary>Plan結果</summary>

```diff
aws_sns_topic.test-1: Refreshing state... [id=arn:aws:sns:ap-northeast-1:xxxxxxxxxxxxxx:topic-test-1]

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
+ create
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # aws_sns_topic.test-1 must be replaced
-/+ resource "aws_sns_topic" "test-1" {
      - application_success_feedback_sample_rate = 0 -> null
      ~ arn                                      = "arn:aws:sns:ap-northeast-1:xxxxxxxxxxxxxx:topic-test-1" -> (known after apply)
      + beginning_archive_time                   = (known after apply)
      - firehose_success_feedback_sample_rate    = 0 -> null
      - http_success_feedback_sample_rate        = 0 -> null
      ~ id                                       = "arn:aws:sns:ap-northeast-1:xxxxxxxxxxxxxx:topic-test-1" -> (known after apply)
      - lambda_success_feedback_sample_rate      = 0 -> null
      ~ name                                     = "topic-test-1" -> "topic-test-2" # forces replacement
      + name_prefix                              = (known after apply)
      ~ owner                                    = "xxxxxxxxxxxxxx" -> (known after apply)
      ~ policy                                   = jsonencode(
            {
              - Id        = "__default_policy_ID"
              - Statement = [
                  - {
                      - Action    = [
                          - "SNS:GetTopicAttributes",
                          - "SNS:SetTopicAttributes",
                          - "SNS:AddPermission",
                          - "SNS:RemovePermission",
                          - "SNS:DeleteTopic",
                          - "SNS:Subscribe",
                          - "SNS:ListSubscriptionsByTopic",
                          - "SNS:Publish",
                        ]
                      - Condition = {
                          - StringEquals = {
                              - "AWS:SourceOwner" = "xxxxxxxxxxxxxx"
                            }
                        }
                      - Effect    = "Allow"
                      - Principal = {
                          - AWS = "*"
                        }
                      - Resource  = "arn:aws:sns:ap-northeast-1:xxxxxxxxxxxxxx:topic-test-1"
                      - Sid       = "__default_statement_ID"
                    },
                ]
              - Version   = "2008-10-17"
            }
        ) -> (known after apply)
      ~ signature_version                        = 0 -> (known after apply)
      - sqs_success_feedback_sample_rate         = 0 -> null
      ~ tags                                     = {
          ~ "Name" = "topic-test-1" -> "topic-test-2"
        }
      ~ tags_all                                 = {
          ~ "Name" = "topic-test-1" -> "topic-test-2"
        }
      + tracing_config                           = (known after apply)
        # (16 unchanged attributes hidden)
    }

  # aws_sns_topic.test-3 will be created
+ resource "aws_sns_topic" "test-3" {
      + arn                         = (known after apply)
      + beginning_archive_time      = (known after apply)
      + content_based_deduplication = false
      + fifo_topic                  = false
      + id                          = (known after apply)
      + name                        = "topic-test-3"
      + name_prefix                 = (known after apply)
      + owner                       = (known after apply)
      + policy                      = (known after apply)
      + signature_version           = (known after apply)
      + tags                        = {
          + "Name" = "topic-test-3"
        }
      + tags_all                    = {
          + "Name" = "topic-test-3"
        }
      + tracing_config              = (known after apply)
    }

Plan: 2 to add, 0 to change, 1 to destroy.
```
</details>

### merge時

<details><summary>Plan結果</summary>

```diff
aws_sns_topic.test-1: Refreshing state... [id=arn:aws:sns:ap-northeast-1:xxxxxxxxxxxxxx:topic-test-1]

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
+ create

Terraform will perform the following actions:

  # aws_sns_topic.test-3 will be created
+ resource "aws_sns_topic" "test-3" {
      + arn                         = (known after apply)
      + beginning_archive_time      = (known after apply)
      + content_based_deduplication = false
      + fifo_topic                  = false
      + id                          = (known after apply)
      + name                        = "topic-test-3"
      + name_prefix                 = (known after apply)
      + owner                       = (known after apply)
      + policy                      = (known after apply)
      + signature_version           = (known after apply)
      + tags                        = {
          + "Name" = "topic-test-3"
        }
      + tags_all                    = {
          + "Name" = "topic-test-3"
        }
      + tracing_config              = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```
</details>
