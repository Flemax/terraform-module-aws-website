data "aws_iam_policy_document" "s3" {
  provider = aws.eu
  statement {
    sid = "AllowS3"
    principals {
      identifiers = [aws_cloudfront_origin_access_identity.oai.iam_arn]
      type        = "AWS"
    }
    effect  = "Allow"
    actions = ["s3:GetObject"]
    resources = [
      "arn:aws:s3:::${var.domain_name}/*",
      "arn:aws:s3:::${var.domain_name}"
    ]
  }
}

resource "aws_s3_bucket" "bucket" {
  provider      = aws.eu
  bucket        = var.domain_name
  force_destroy = true
  policy        = data.aws_iam_policy_document.s3.json
  tags          = var.tags
}

resource "aws_s3_bucket_object" "index_html" {
  count        = var.enable_index_file_in_bucket == true ? 1 : 0
  provider     = aws.eu
  key          = "index.html"
  content_type = "text/html"
  bucket       = aws_s3_bucket.bucket.id
  content      = <<EOF
<!doctype html>
<html lang="fr">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
	<link href="https://fonts.googleapis.com/css2?family=Epilogue&display=swap" rel="stylesheet">
	<title>Site en préparation</title>
  </head>
  <body>
	<div class="container">
		<div class="row">
			<div class="mx-auto my-5">
				<h1>Le site est en cours de préparation<span id="wait"></span></h1>
			</div>
		</div>
	</div>
	<script>
		points = "."
		wait = document.getElementById("wait");
		setInterval(function () {
			wait.innerHTML = points
			points += "."
			if (points.length >= 4){
				points = ""
			}
		}, 1000);
	</script>
	<style>
		* {
			font-family: "Epilogue", sans-serif;
		}
	</style>
  </body>
</html>
EOF
}