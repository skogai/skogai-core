#!/usr/bin/env bash

setup_test_dir() {
  export TEST_DIR
  TEST_DIR="$(mktemp -d -t skogai-tests.XXXXXX)"
}

teardown_test_dir() {
  if [[ -n "${TEST_DIR:-}" && -d "$TEST_DIR" ]]; then
    rm -rf "$TEST_DIR"
  fi
}

assert_success() {
  # `run` assigns these Bats globals before assertions execute.
  # shellcheck disable=SC2154
  if [[ "$status" -ne 0 ]]; then
    printf 'Expected success, got status %s\nOutput: %s\n' "$status" "$output"
    return 1
  fi
}

assert_output_equals() {
  local expected="$1"
  if [[ "$output" != "$expected" ]]; then
    printf 'Expected: %s\nActual: %s\n' "$expected" "$output"
    return 1
  fi
}

assert_output_contains() {
  local expected="$1"
  if [[ "$output" != *"$expected"* ]]; then
    printf 'Expected output to contain: %s\nActual: %s\n' "$expected" "$output"
    return 1
  fi
}

assert_file_exists() {
  local file="$1"
  if [[ ! -f "$file" ]]; then
    printf 'Expected file to exist: %s\n' "$file"
    return 1
  fi
}

wait_for_file() {
  local file="$1"
  local remaining=50

  while ((remaining > 0)); do
    [[ -s "$file" ]] && return 0
    sleep 0.02
    remaining=$((remaining - 1))
  done

  printf 'Timed out waiting for file: %s\n' "$file"
  return 1
}

wait_for_lines() {
  local expected="$1"
  local file="$2"
  local remaining=50

  while ((remaining > 0)); do
    [[ -f "$file" ]] && [[ "$(wc -l <"$file")" -ge "$expected" ]] && return 0
    sleep 0.02
    remaining=$((remaining - 1))
  done

  printf 'Timed out waiting for %s lines in: %s\n' "$expected" "$file"
  return 1
}
