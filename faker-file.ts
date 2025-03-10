import { faker } from "@faker-js/faker/."
import {
  PrismaClient,
  LaptopModel,
  LaptopStatus,
  LaptopOnImage,
  LaptopOnCart,
  LaptopOnSale,
  Customer,
  Account,
  Laptop,
  Admin,
  Image,
  Color,
  Cart,
  Role,
} from "@prisma/client"


const prisma = new PrismaClient()

const randomEnum = <T>(enumObject: { [key: string]: T }): T => {
  const values = Object.values(enumObject)
  return values[Math.floor(Math.random() * values.length)]
}

async function createRoles() {
  const rolesData = [
    {
      name: "admin",
    },
    {
      name: "customer",
    },
  ]

  for (const role of rolesData) {
    await prisma.role.create({
      data: role,
    })
  }
  console.log("Roles created")
}

async function createAcccounts(count: number) {
  const accountsData: any[] = []

  for (let i = 0; i < count; i++) {
    try {
      const isAdmin = Math.random() < 0.2
      const userName = faker.internet.userName()
      const password = faker.internet.password()
      const email = faker.internet.email()
      const role = isAdmin ? "admin" : "customer"


      const account = {
        userName,
        password,
        email,
        role: {
          connect: {
            name: role,
          },
        },
      }

      accountsData.push(account)
    }
    catch (error) {
      console.error(error)
    }

    await prisma.account.createMany({
      data: accountsData,
      skipDuplicates: true,
    })

    const createdAccounts = await prisma.account.findMany({
      where: {
        name: {
          in: accountsData.map((account) => account.userName),
        }
      }
    })


    console.log("Accounts created")

  }
}


