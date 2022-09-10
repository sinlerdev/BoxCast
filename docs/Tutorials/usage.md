# **Usage**

## **Creating Casters**
Creating casters is easy and straightforward using the `BoxCast.new()` constructor!

```Lua

local BoxCast = require(PATH_TO_BOXCAST)

local Caster = BoxCast.new()
```

This errors as we haven't given any information for BoxCast to use, let's start doing that! Firstly, we need our caster to be 5 studs tall and 6 studs width. To acheive this, we can use the `Thickness` property for tallness, and `Quality` for the wide!

```Lua

local Caster = BoxCast.new({
    Thickness = 5, -- The Caster will now cast a 5-stud tall box
    Quality = 6, -- The caster will now cast a 6-stud as width box
})
```
This creates a Caster with 5 stud thickness and 6-stud quality, however, we also need to provide an `Ignore` property - it is responsible for making the caster ignore any descendent of that table.

```Lua

local Caster = BoxCast.new({
    Thickness = 5, -- The Caster will now cast a 5-stud tall box
    Quality = 6, -- The caster will now cast a 6-stud as width box,
    Ignore = {workspace.PART} -- indicates that the BasePart named `PART` will be ignored
})
```

Congratulations! Now you have a functioning Caster, but there is still more!

In Caster construction, there are 4 properties for determining how to use both the `Quality` and the `Thickness` properties, which are the following:

1. PlaneAdvancement 
2. PlaneDistance
3. PointAdvancement
4. PointDistance

But, what are specifically those? Well, let's start with the simplest and then the hardest!

### **Distances**

Distances properties are the factors to determine how close your points/planes to each other. They are measured in studs, so you can technically manipulate how the Caster object behaves with `Thickness` & `Quality`.

Let's start with the `PointDistance` property. It is responsible for distancing between points in a plane, so for example, if we have 4 as quality, and 2 as PointDistance, then all of our planes will be 8-studs wide, while if 1 as PointDistance, then our planes will be 4-studs wide.

Moreover, the `PlaneDistance` property is responsible for distancing between planes in a Box, so for example, if have 6 as Thicknes and 2 as PlaneDistance, then our whole Box will be 12-studs tall.

!!! Caution
    Keep in mind that increasing Distances doesn't necessarily mean increasing the destiny of our boxes. Use Advancements instead.

### **Advancements** 

Unlike Distences, Advancements manage how precious is your box within the space provided. So for example, `PlaneAdvancement` will determine how many planes to be casted in a in `Thickness` studs tall, so for an instance, if you had 4 as Thickness and 0.1 as `PlaneAdvancement`, then the Caster object will casts 40 planes in those 4-studs.  The same applies with `PointAdvancement`, where it determines how many points to be casted in a plane - so if we had 4 as Quality and 0.1 as `PointAdvancement` then our Caster object will cast 10 rays per a plane, with total as 40 rays.


## **Casting Boxes**

Now that you are aware of how to use `Caster.new()`, you can learn how to cast Boxes using `Caster:cast()`!

