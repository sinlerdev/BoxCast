# **Best Practices**
This page contains some helpful notes to be aware of when using BoxCast.


## **Use Generalized Casters**
Something that beginners would fall into is creating a caster for each object that needs BoxCast. However, it is **greatly recommended** to reuse Casters as much as possible. The following rules will help you in shaping what you should do in most cases - these rules target swords, but they would still make sense generally.

* If you are making dynamic-sized-swords....
    * If you are following certian stages when sizing the sword dynamically, then you can create a generalized caster for each of those stages. 
    * If you are not following certian rules, such as sizing the sword based on the character's size, then create a caster for that sword instance and rebuild it as much as needed

* If you are making static-sized swords...
    * If your swords have types, then consider creating a generalized caster for each type.


## **Rebuild Only When Needed**
Rebuilding should be limited to reusing casters if your use-case can't use generalized casters, and it is important to know what `Caster:rebuild()` optimizes and whatnot.

* the `Caster:rebuild()` only updates the necessary properties...
    * Or in other words, you pay for what you use.
* However, the `Caster:rebuild()` will still recalculate if given the same properties
    * One reason for this is to be clear that rebuilding is something highly expensive.
    * Additionally, this would need the method to be reworked to something a bit complex than it is now.

## **Advancements vs Distances**
When working with Advancements *(PlaneAdvancement/PointAdvancement)* and Distances *(PointDistance/PlaneDistance)*, it is important to use the right one for your use-case.

* Use Advancements when you want to....
    * Control how Casters would manage either Quality or Thickness. The lesser value of an advancement, the more value Quality/Thickness holds i.e Thickness as 4 while PlaneAdvancement as 0.5 will cast 8 rays. This is useful for control over precious.

* Use Distances when you want to....
    * Determine the distance between each point/Plane. Useful for making swords.