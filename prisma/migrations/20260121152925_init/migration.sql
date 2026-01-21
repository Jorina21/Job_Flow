-- CreateEnum
CREATE TYPE "ApplicationSource" AS ENUM ('LinkedIn', 'Indeed', 'Referral', 'CompanySite', 'Recruiter', 'Other');

-- CreateEnum
CREATE TYPE "ApplicationStatus" AS ENUM ('Draft', 'Applied', 'OA', 'PhoneScreen', 'TechnicalInterview', 'Onsite', 'Offer', 'Rejected', 'Withdrawn');

-- CreateEnum
CREATE TYPE "Priority" AS ENUM ('Low', 'Medium', 'High');

-- CreateEnum
CREATE TYPE "InterviewType" AS ENUM ('RecruiterCall', 'PhoneScreen', 'Technical', 'Behavioral', 'Onsite', 'FinalRound', 'Other');

-- CreateEnum
CREATE TYPE "InterviewOutcome" AS ENUM ('Pending', 'Passed', 'Failed', 'NoShow', 'Rescheduled');

-- CreateEnum
CREATE TYPE "ActivityActionType" AS ENUM ('APPLICATION_CREATED', 'APPLICATION_UPDATED', 'STATUS_CHANGED', 'FOLLOWUP_CHANGED', 'INTERVIEW_SCHEDULED', 'INTERVIEW_UPDATED', 'INTERVIEW_DELETED', 'NOTE_UPDATED');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "fullName" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JobApplication" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "companyName" TEXT NOT NULL,
    "roleTitle" TEXT NOT NULL,
    "location" TEXT,
    "jobUrl" TEXT,
    "source" "ApplicationSource" NOT NULL DEFAULT 'Other',
    "status" "ApplicationStatus" NOT NULL DEFAULT 'Draft',
    "salaryMin" INTEGER,
    "salaryMax" INTEGER,
    "compensationNotes" TEXT,
    "resumeVersion" TEXT,
    "coverLetterUsed" BOOLEAN DEFAULT false,
    "priority" "Priority" NOT NULL DEFAULT 'Medium',
    "appliedDate" TIMESTAMP(3),
    "nextFollowUpDate" TIMESTAMP(3),
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JobApplication_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InterviewEvent" (
    "id" TEXT NOT NULL,
    "applicationId" TEXT NOT NULL,
    "type" "InterviewType" NOT NULL,
    "scheduledAt" TIMESTAMP(3) NOT NULL,
    "durationMinutes" INTEGER,
    "meetingLink" TEXT,
    "location" TEXT,
    "interviewerNames" TEXT,
    "notes" TEXT,
    "outcome" "InterviewOutcome" NOT NULL DEFAULT 'Pending',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "InterviewEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ActivityLog" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "applicationId" TEXT,
    "actionType" "ActivityActionType" NOT NULL,
    "message" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ActivityLog_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "User_email_idx" ON "User"("email");

-- CreateIndex
CREATE INDEX "JobApplication_userId_idx" ON "JobApplication"("userId");

-- CreateIndex
CREATE INDEX "JobApplication_status_idx" ON "JobApplication"("status");

-- CreateIndex
CREATE INDEX "JobApplication_source_idx" ON "JobApplication"("source");

-- CreateIndex
CREATE INDEX "JobApplication_priority_idx" ON "JobApplication"("priority");

-- CreateIndex
CREATE INDEX "JobApplication_appliedDate_idx" ON "JobApplication"("appliedDate");

-- CreateIndex
CREATE INDEX "JobApplication_createdAt_idx" ON "JobApplication"("createdAt");

-- CreateIndex
CREATE INDEX "InterviewEvent_applicationId_idx" ON "InterviewEvent"("applicationId");

-- CreateIndex
CREATE INDEX "InterviewEvent_scheduledAt_idx" ON "InterviewEvent"("scheduledAt");

-- CreateIndex
CREATE INDEX "ActivityLog_userId_createdAt_idx" ON "ActivityLog"("userId", "createdAt");

-- CreateIndex
CREATE INDEX "ActivityLog_applicationId_createdAt_idx" ON "ActivityLog"("applicationId", "createdAt");

-- AddForeignKey
ALTER TABLE "JobApplication" ADD CONSTRAINT "JobApplication_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InterviewEvent" ADD CONSTRAINT "InterviewEvent_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "JobApplication"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ActivityLog" ADD CONSTRAINT "ActivityLog_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ActivityLog" ADD CONSTRAINT "ActivityLog_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "JobApplication"("id") ON DELETE CASCADE ON UPDATE CASCADE;
