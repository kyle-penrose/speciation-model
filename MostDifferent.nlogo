globals
[
  timestep          ; counts how much time has passed
]

turtles-own
[
  genome
  genomei
  genomef
]

to setup
  let step 0

 ; random-seed 83

  clear-output
  ;; (for this model to work with NetLogo's new plotting features,
  ;; __clear-all-and-reset-ticks should be replaced with clear-all at
  ;; the beginning of your setup procedure and reset-ticks at the end
  ;; of the procedure.)
  ;; __clear-all-and-reset-ticks
  clear-all
  set timestep 0
  crt num-agents
  [
    set genomei 0
    set genome list (random 2) (random 2)
    repeat genome-size - 2 [
            set genome lput (random 2) genome
    ]
    ; print genome
    set step 0
    repeat genome-size [
      ifelse ( item step genome = 0 )
      [ set genomei genomei * 2 ]
      [ set genomei 1 + genomei * 2]
      set step step + 1
    ]
    set genomef genomei / (2 ^ genome-size)
    set color round(139.0 * genomef)
    set size 3
    set shape "circle"
    setxy (random-float world-width)
          (random-float world-height)    ; randomize turtle locations
  ]
  setup-plot
  plot-genomes
end

to go
  if moving
  [ move
  ]
  mate
  set timestep timestep + 1
  plot-genomes
  reset-ticks
end

to move
  ask turtles
  [
    rt random-float 30 - random-float 30
    fd 2
  ]
end

to mate
  let difference 0
  let biggest-difference 0
  let most-different 0
  let me 0
  let friends []
  let step 0
  let cross-over1 0
  let cross-over2 0

;  without-interruption [
    ask turtles [
      set biggest-difference 0
      set me self
      set friends []
      ifelse region
      [ ask turtles in-radius region-size [
        set friends lput self friends
        ]
      ]
      [ ask other turtles
        [ set friends lput self friends ]
      ]
      foreach friends [ ?1 ->
        set difference 0
        set step 0
        repeat genome-size [
          if ( item step [genome] of ?1 != item step [genome] of me )
            [ set difference difference + 1 ]
          set step step + 1
        ]
        if ( difference > biggest-difference )
        [  set biggest-difference difference
           set most-different ?1
        ]
      ]

      if least [
        set biggest-difference genome-size
        foreach friends [ ?1 ->
           set difference 0
           set step 0
           repeat genome-size [
             if ( item step [genome] of ?1 != item step [genome] of me )
               [ set difference difference + 1 ]
             set step step + 1
          ]
          if ( difference < biggest-difference )
           [  set biggest-difference difference
              set most-different ?1
           ]
         ]
      ]

    set step 0

;    set cross-over1 random (genome-size / 3.0) + round(genome-size / 3.0)

    ifelse (fixed)
       [ set cross-over1  crossover-location ]
       [ ifelse (uniform)
         [ set cross-over1 random genome-size ]
         [ set cross-over1 random-normal (genome-size / 2.0) (genome-size / 6.0) ]
       ]
    ifelse (either)
      [ set cross-over2 random 2 ]
      [ set cross-over2 1 ]
    repeat genome-size [
      ifelse (cross-over2 = 0)
      [ if (step >= cross-over1)
        [set genome replace-item step genome item step [genome] of most-different]
      ]
      [ if (step < cross-over1)
        [set genome replace-item step genome item step [genome] of most-different]
      ]
      if (mutate and ((random one-over-mutation-rate) = 0))
      [set genome replace-item step genome (1 - (item step genome))]
   ;   [ set genome-of most-different replace-item step genome-of most-different item step genome
    ;  ]
      set step step + 1
    ]
    set step 0
    set genomei 0
    repeat genome-size [
      ifelse ( item step genome = 0 )
      [ set genomei genomei * 2 ]
      [ set genomei 1 + genomei * 2]
      set step step + 1
    ]
    set genomef genomei / (2 ^ genome-size)
    set color round(139.0 * genomef)

   ]
 ; ]

end


to plot-genomes
  set-current-plot "Genomes"
  set-current-plot-pen "genomes"
  if full-plot
  [  ask turtles [
    plotxy timestep genomef
    ]
  ]

  set-current-plot "Genome-distribution"
  set-current-plot-pen "agents"
  histogram [genomei] of turtles
end


to setup-plot

  set-current-plot "Genomes"
  set-plot-x-range 0 400
  set-plot-y-range 0 1.0

  set-current-plot "Genome-distribution"
  set-plot-x-range 0 2 ^ genome-size
  set-plot-y-range 0 round ((count turtles) / 5)
  set-histogram-num-bars 100
end
@#$#@#$#@
GRAPHICS-WINDOW
290
22
694
426
-1
-1
4
1
10
1
1
1
0
1
1
1
-50
50
-50
50
0
0
1
ticks
30

SLIDER
14
58
186
91
num-agents
num-agents
10
1000
350
10
1
agents
HORIZONTAL

BUTTON
15
17
70
50
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
74
17
129
50
go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
2
254
282
457
genomes
timestep
genome
0
400
0
1
true
true
"" ""
PENS
"genomes" 5 2 -5825686 false "" ""

MONITOR
933
37
1006
82
Time Step
timestep
3
1
11

SWITCH
190
58
280
91
moving
moving
0
1
-1000

BUTTON
132
17
187
50
step
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
14
98
186
131
region-size
region-size
3
50
16
1
1
NIL
HORIZONTAL

PLOT
716
108
1015
403
Genome-distribution
genome
number
0
1
0
1
true
false
"" ""
PENS
"agents" 1 1 -16777216 true "" ""

SLIDER
14
136
186
169
one-over-mutation-rate
one-over-mutation-rate
100
500
175
5
1
NIL
HORIZONTAL

SLIDER
14
174
186
207
genome-size
genome-size
12
24
20
4
1
NIL
HORIZONTAL

SWITCH
192
212
282
245
fixed
fixed
1
1
-1000

SLIDER
14
211
186
244
crossover-location
crossover-location
0
24
2
1
1
NIL
HORIZONTAL

SWITCH
191
174
281
207
uniform
uniform
1
1
-1000

SWITCH
191
17
283
50
full-plot
full-plot
0
1
-1000

SWITCH
189
97
280
130
region
region
0
1
-1000

SWITCH
190
135
280
168
mutate
mutate
0
1
-1000

SWITCH
715
47
818
80
least
least
1
1
-1000

SWITCH
824
47
928
80
either
either
0
1
-1000
@#$#@#$#@
## WHAT IS IT?

This NetLogo simulation is aimed at stimulating some thought about evolutionary processes.

The basic idea is this:  there are a bunch of agents, each with a "genome" (a string of bits).  At each time step, each agent looks at its (nearby) neighbors and selects one to mate with.  The selection algorithm is to choose the neighbor who is most different (hamming distance of genomes) from you.  Reproduction is replacement of self by a single offspring, whose genome is the result of a crossover with the mate (a crossover point is selected; the new genome results from one parent up to the crossover point, and the other parent from there on -- which parent selected at random).  The crossover point is selected from a normal distribution with mean genome-size / 2, and standard deviation genome-size / 6.  There is also the possibility of mutation of a "gene" (a bit in the genome).


## HOW TO USE IT

Each pass through the GO function represents one time step.

The histogram shows the number of agents having a given range of genomes.  The genomes are represented as the binary number corresponding to the genome bit string.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

abc
true
0
Line -5825686 false 75 60 210 195
Rectangle -5825686 false false 105 45 210 105
Circle -5825686 true false 33 93 85
Circle -5825686 true false 174 129 42
Rectangle -5825686 true false 148 190 186 229

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
true
0
Polygon -7500403 true true 45 255 255 255 255 45 45 45

circle
true
0
Circle -7500403 true true 35 35 230

link
true
0
Line -7500403 true 150 0 150 300

link direction
true
0
Line -7500403 true 150 150 30 225
Line -7500403 true 150 150 270 225

person
false
0
Circle -7500403 true true 155 20 63
Rectangle -7500403 true true 158 79 217 164
Polygon -7500403 true true 158 81 110 129 131 143 158 109 165 110
Polygon -7500403 true true 216 83 267 123 248 143 215 107
Polygon -7500403 true true 167 163 145 234 183 234 183 163
Polygon -7500403 true true 195 163 195 233 227 233 206 159

spacecraft
true
0
Polygon -7500403 true true 150 0 180 135 255 255 225 240 150 180 75 240 45 255 120 135

thin-arrow
true
0
Polygon -7500403 true true 150 0 0 150 120 150 120 293 180 293 180 150 300 150

truck-down
false
0
Polygon -7500403 true true 225 30 225 270 120 270 105 210 60 180 45 30 105 60 105 30
Polygon -8630108 true false 195 75 195 120 240 120 240 75
Polygon -8630108 true false 195 225 195 180 240 180 240 225

truck-left
false
0
Polygon -7500403 true true 120 135 225 135 225 210 75 210 75 165 105 165
Polygon -8630108 true false 90 210 105 225 120 210
Polygon -8630108 true false 180 210 195 225 210 210

truck-right
false
0
Polygon -7500403 true true 180 135 75 135 75 210 225 210 225 165 195 165
Polygon -8630108 true false 210 210 195 225 180 210
Polygon -8630108 true false 120 210 105 225 90 210

turtle
true
0
Polygon -7500403 true true 138 75 162 75 165 105 225 105 225 142 195 135 195 187 225 195 225 225 195 217 195 202 105 202 105 217 75 225 75 195 105 187 105 135 75 142 75 105 135 105
@#$#@#$#@
NetLogo 6.1.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0
-0.2 0 0 1
0 1 1 0
0.2 0 0 1
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@

@#$#@#$#@
