---
layout: post
title: "#00001: The Nature Of Code: Smart Rockets"
date: 2017-12-16
---

<canvas data-processing-sources="/projects/TheNatureOfCode/canvases/00001.pde"></canvas>
<p> Two populations of evolving smart rockets made with the help of <a href="http://natureofcode.com/book/chapter-9-the-evolution-of-code/">Chapter 9</a> of the amazing <a href="http://natureofcode.com/book/">Nature Of Code Book</a>.</p>
<p>Code on <a href="https://github.com/Oadegbite/Oadegbite.github.io/tree/master/projects/TheNatureOfCode/E9_10SmartRocketsRedvsBlue">Github</a></p>

<h2><u>The Idea:</u></h2>
<p>To use a genetic algorith to solve a problem.</p>

<p><h2>The Problem:</h2></p>
<p>To navigate to a target with a radius of 50 pixels at an unknown location on a 780x900 pixel plane, this problem has a wide search space with many possible locations for the target and a narrow set of solutions. The fitness of solutions can be judged easily, fitness being closeness to the target and the best solutions hitting the target.</p>

<p><h2>The Solution:</h2></p>
<p>Two populations of ships that navigate based on DNA consisting of directions that are followed over time, the ships in each population with the highest fitness have their directions passed on at a higher rate in their population.</p>

<p><h2>The variables:</h2></p>
<p><em><strong>Generation:</strong></em> Number of generations since start of scene, where the next generation is made up of ships whose parents were the ships in the previous generation with the highest fitness.</p>
<p><em><strong>Population Fitness:</strong></em> The average fitness of the population, fitness as measured by a fitness function being the method of selection based on how close the ship gets to the target.</p>
<p><em><strong>Life:</strong></em> The amount of time till death and start of new generation. </p>
<p><em><strong>Population Size:</strong></em> Number of ships in the population.</p>
<p><em><strong>Mutation Rate:</strong></em> The rate at which new directions are added to ships DNA to test for other methods of raising fitness by trying to find the target in new locations.
  <ul>
    <li><p>Increasing mutation rate ships are more likely to change directions in their DNA passed on from their parents, with too high a mutation the population loses a sense of the target and go in random directions.</p></li>
    <li><p>Decreasing mutation rate ships are less likely to to change directions in their DNA passed on from their parents, with too little mutation the population follows very closely path traced out by parents and if the target mose they cannot adapt.</p></li>
  </ul>
</p>


<h2><u>The Implementation:</u></h2>
<p></p>

<h2><u>Next Steps:</u></h2>

<h2><u>Additional Resources:</u></h2>

<p>This project was made with <a href="https://processing.org/">Processing</a>.</p>
<p>Embedded into the web with <a href="http://processingjs.org/">ProcessingJs</a>.</p>
<p>Inspired by the <a href="http://natureofcode.com/book/">Nature Of Code Book</a> and <a href="https://www.youtube.com/channel/UCvjgXvBlbQiydffZU7m1_aw">The Coding Train Youtube Channel</a>. </p>
