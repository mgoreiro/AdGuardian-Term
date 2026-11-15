#!/usr/bin/env bash
# Cross-compila AdGuardian-Term para Orange Pi Zero 2 (Allwinner H616, Cortex-A53, aarch64).
# Requiere Docker. Genera ./orangepi/adguardian (necesita glibc >= 2.34).
set -euo pipefail
cd "$(dirname "$0")/.."
docker run --rm --platform linux/arm64 -v "$PWD":/work -w /work \
  -e RUSTFLAGS="-C target-cpu=cortex-a53" rust:1-bookworm bash -c \
  'apt-get update -qq && apt-get install -y -qq cmake >/dev/null && cargo build --release --target-dir /tmp/t && cp /tmp/t/release/adguardian orangepi/adguardian && strip orangepi/adguardian'
