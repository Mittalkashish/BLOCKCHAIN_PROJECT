# Decentralized-Identity-management

<p align="center">
  <img src="https://img.shields.io/github/stars/reshmaharidhas/Decentralized-Identity-management?style=social">
  <img src="https://img.shields.io/tokei/lines/github/reshmaharidhas/Decentralized-Identity-management">
  <img src="https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2Freshmaharidhas%2FDecentralized-Identity-management&label=Visitors&labelColor=%23000000&countColor=%2300ff00&style=plastic" />
 </p>

# We are using Circom & SnarkJS to integrade Zero Knowledge Proof

## 🔧 Circom & SnarkJS Setup - Windows (Command-Only Guide)

### 1. Install Node.js and Git (manually via browser)

- Node.js: https://nodejs.org (LTS)
- Git Bash: https://git-scm.com/download/win

---

### 2. Install Rust

```bash
curl https://sh.rustup.rs -sSf | sh
rustup update
rustc -V
```

### Build circom from source

```bash
git clone https://github.com/iden3/circom.git
cd circom
cargo build --release
export PATH=$PATH:$(pwd)/target/release
./target/release/circom --help
```

### Install snarkjk globaly

```bash
npm install -g snarkjs
snarkjs --help
```

### Verify

```bash
circom --version
snarkjs --version
```

A Dapp for Identity Management. This is a simple dapp idea deployed in Ropsten test network.

index.html is the homepage.

```

```
