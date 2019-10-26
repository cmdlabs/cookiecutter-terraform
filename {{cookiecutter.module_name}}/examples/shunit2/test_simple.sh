#!/usr/bin/env bash

. shunit2/test_helper.sh

vars=(
  AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY
)
validateVars

testSimple() {
  cd simple

  if ! terraform apply -auto-approve ; then
    fail "terraform did not apply"
    startSkipping
  fi

  cd ..
}

testSomething() {
  read -r foo bar <<< "$(
    aws budgets describe-something --account-id "$AWS_ACCOUNT_ID" \
      --query 'Something[0].Stuff.[Foo, Bar]' --output text
  )"
  assertEquals "unexpected foo" "foo" "$foo"
  assertEquals "unexpected bar" "bar" "$bar"
}

oneTimeTearDown() {
  if [ "$NO_TEARDOWN" != "true" ] ; then
    cd simple
    terraform destroy -auto-approve
    cd ..
  fi
}

. shunit2
