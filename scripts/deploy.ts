import { ethers } from "hardhat";

async function main() {

  const E20Factory = await ethers.getContractFactory("E20Factory");
  const e20Factory = await E20Factory.deploy();

  await e20Factory.deployed();

  console.log("E20Factory deployed to:", e20Factory.address);
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
