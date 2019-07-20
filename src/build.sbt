name := """play-in-docker"""
version := sys.env.get("PLAY_VERSION").get

lazy val root = (project in file(".")).enablePlugins(PlayJava)

scalaVersion := sys.env.get("SCALA_VERSION").get

crossScalaVersions := Seq("2.12.8", sys.env.get("SCALA_VERSION").get)
