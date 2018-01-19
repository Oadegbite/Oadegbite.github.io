---
layout: post
title: "#00001: The Nature Of Code: Smart Rockets"
date: 2017-12-16
---

<canvas data-processing-sources="/projects/canvases/00001.pde"></canvas>
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
<p><em><strong>Population Fitness:</strong></em> The average fitness of the population, fitness measured by a fitness function based on how close the ship gets to the target with a bonus for ships that hit it.</p>
<p><em><strong>Life:</strong></em> The amount of time till death and start of new generation. </p>
<p><em><strong>Population Size:</strong></em> Number of ships in the population.</p>
<p><em><strong>Mutation Rate:</strong></em> The rate at which new directions are added to ships DNA to test for other methods of raising fitness by trying to find the target in new locations.
  <ul>
    <li><p>Increasing mutation rate ships are more likely to change directions in their DNA passed on from their parents, with too high a mutation the population loses a sense of the target and go in random directions.</p></li>
    <li><p>Decreasing mutation rate ships are less likely to to change directions in their DNA passed on from their parents, with too little mutation the population follows very closely path traced out by parents and if the target mose they cannot adapt.</p></li>
  </ul>
</p>


<h2><u>The Implementation:</u></h2>
<p>The main parts of the system are the <a href="https://github.com/Oadegbite/Oadegbite.github.io/blob/master/projects/TheNatureOfCode/E9_10SmartRocketsRedvsBlue/DNA.pde">DNA</a> object, <a href="https://github.com/Oadegbite/Oadegbite.github.io/blob/master/projects/TheNatureOfCode/E9_10SmartRocketsRedvsBlue/Rocket.pde">Rocket</a> object, and <a href="https://github.com/Oadegbite/Oadegbite.github.io/blob/master/projects/TheNatureOfCode/E9_10SmartRocketsRedvsBlue/Population.pde">Population</a> object</p>

<p><h2>DNA:</h2></p>

<p>The DNA object has genes which are an array of vectors as long as the life of the rocket.</p>

<p>A crossover method to combine genes of of 2 different rockets.</p>

<p>A mutuate method to mutate the DNA according to the mutation rate.</p>

<p><h2>Rocket:</h2></p>

<p>Each rocket has a DNA object which it follows using the applyForce method to apply the PVector for that stage of its life.</p>

<p>A Fitness method that implements the fitness function that sets the rockets fitness depending on if it hit or miss the target and how close it got.</p>

<p><h2>Population:</h2></p>

<p>The Population object controls the main parts of the genetic algorithm creating an initial random population, selection of fittest rockets, and reproduction.</p>

<p>A fitness method to evaluate the fitness of every rocket in the population, and calculate the populations fitness.</p>

<p>A selection method using a monte carlo selection algorithm that increases the likelihood of the rocket being place in the mating pool depending on its fitness. The more fit the higher chance the less fit the lower chance.</p>

<p>A reproduction method that selects two random rockets in the mating pool and produces a new rocket using DNA from both rockets and adds a mutation rate to preserve variation in the population.</p>

<h2><u>Next Steps:</u></h2>

<p>Improve the fitness function by adding the speed that a rocket reaches the target to evolve a more optimal path.</p>

<p>A limited awareness of the surrounding so the rocket knows when it's close to the rocket and steers towards it.</p>

<p>A more complex environment and an environment that's continuous instead of sequential generations similar to <a href="https://www.youtube.com/watch?v=ykOcaInciBI&t=3s">this example.</a></p>

<h2><u>Additional Resources:</u></h2>

<p>This project was made with <a href="https://processing.org/">Processing</a>.</p>
<p>Embedded into the web with <a href="http://processingjs.org/">ProcessingJs</a>.</p>
<p>Inspired by the <a href="http://natureofcode.com/book/">Nature Of Code Book</a> and <a href="https://www.youtube.com/channel/UCvjgXvBlbQiydffZU7m1_aw">The Coding Train Youtube Channel</a>. </p>
