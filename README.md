# AnimationKit

### Sequential animation tasks
`-->`  operator to create a group of sequential animations
```
let animation = Animation("submit")
    --> (0.3, { self.submitButton.center = CGPoint(x: center.x, y: 100) })
    --> (0.3, { self.submitButton.center = center })
```

### Concurrent animation tasks
`|||`  operator to create a group of concurrent animations
```
let animation = Animation("submit")
    ||| (0.3, { self.submitButton.center = CGPoint(x: center.x, y: 100) })
    ||| (0.3, { self.submitButton.alpha = 0 } )
```
