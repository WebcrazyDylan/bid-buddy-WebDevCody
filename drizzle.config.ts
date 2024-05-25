import { env } from "@/env";
import { defineConfig } from "drizzle-kit";

export default defineConfig({
  schema: "./src/db/schema.ts",
  dialect: "postgresql",
  out: "./src/db/drizzle",
  dbCredentials: {
    host: env.DB_HOST,
    port: env.DB_PORT,
  },
  verbose: true,
  strict: true,
});
