name := """docker-play"""
version := "2.7.2"

lazy val root = (project in file(".")).enablePlugins(PlayScala)

scalaVersion := "2.13.0"

javacOptions ++= Seq(
  "-encoding", "UTF-8",
  "-parameters",
  "-Xlint:unchecked",
  "-Xlint:deprecation",
  "-Werror"
)

crossScalaVersions := Seq("2.11.12", "2.13.0")

libraryDependencies ++= Seq(
  guice,
  "com.h2database" % "h2" % "1.4.199",
  "org.assertj" % "assertj-core" % "3.11.1" % Test,
  "org.awaitility" % "awaitility" % "3.1.3" % Test
)

testOptions in Test := Seq(Tests.Argument(TestFrameworks.JUnit, "-a", "-v"))
