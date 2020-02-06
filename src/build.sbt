name := """play-in-docker"""

version := sys.env.get("PLAY_VERSION").get

lazy val root = (project in file(".")).enablePlugins(PlayScala)

scalaVersion := sys.env.get("SCALA_VERSION").get

crossScalaVersions := Seq("2.12.10", sys.env.get("SCALA_VERSION").get)

logLevel := Level.Error

updateOptions := updateOptions.value.withCachedResolution(true)
