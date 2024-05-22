CREATE TABLE IF NOT EXISTS "bb_account" (
	"userId" text NOT NULL,
	"type" text NOT NULL,
	"provider" text NOT NULL,
	"providerAccountId" text NOT NULL,
	"refresh_token" text,
	"access_token" text,
	"expires_at" integer,
	"token_type" text,
	"scope" text,
	"id_token" text,
	"session_state" text,
	CONSTRAINT "bb_account_provider_providerAccountId_pk" PRIMARY KEY("provider","providerAccountId")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "bb_bids" (
	"id" serial PRIMARY KEY NOT NULL,
	"amount" integer NOT NULL,
	"itemId" serial NOT NULL,
	"userId" text NOT NULL,
	"timestamp" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "bb_item" (
	"id" serial PRIMARY KEY NOT NULL,
	"userId" text NOT NULL,
	"name" text NOT NULL,
	"fileKey" text NOT NULL,
	"currentBid" integer DEFAULT 0 NOT NULL,
	"startingPrice" integer DEFAULT 0 NOT NULL,
	"bidInterval" integer DEFAULT 100 NOT NULL,
	"endDate" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "bb_session" (
	"sessionToken" text PRIMARY KEY NOT NULL,
	"userId" text NOT NULL,
	"expires" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "bb_user" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text,
	"email" text NOT NULL,
	"emailVerified" timestamp,
	"image" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "bb_verificationToken" (
	"identifier" text NOT NULL,
	"token" text NOT NULL,
	"expires" timestamp NOT NULL,
	CONSTRAINT "bb_verificationToken_identifier_token_pk" PRIMARY KEY("identifier","token")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "bb_account" ADD CONSTRAINT "bb_account_userId_bb_user_id_fk" FOREIGN KEY ("userId") REFERENCES "public"."bb_user"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "bb_bids" ADD CONSTRAINT "bb_bids_itemId_bb_item_id_fk" FOREIGN KEY ("itemId") REFERENCES "public"."bb_item"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "bb_bids" ADD CONSTRAINT "bb_bids_userId_bb_user_id_fk" FOREIGN KEY ("userId") REFERENCES "public"."bb_user"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "bb_item" ADD CONSTRAINT "bb_item_userId_bb_user_id_fk" FOREIGN KEY ("userId") REFERENCES "public"."bb_user"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "bb_session" ADD CONSTRAINT "bb_session_userId_bb_user_id_fk" FOREIGN KEY ("userId") REFERENCES "public"."bb_user"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
