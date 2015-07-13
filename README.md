# Introduction

This library was originally written to add CSS3 selector and style support to ActionScript 3 projects. It is no longer maintained, though the selector engine and style matching are tested and very functional.

The documentation below is what was available on Google Code when the project went cold.

# CSSContext

The CSS context object is used to configure the CSS engine by defining 
the main object factory (`ICSSFactory`), CSS property definitions (`IPropertyManager`),
and object-CSS views (`ICSSView`). Every CSS instance requires a context object.

## Details

`CSSContext` is the base implementation of `ICSSContext` and is the leanest configuration.

`CSS3Context` is an implementation of `ICSSContext` that contains the property and shorthand
managers specific to CSS3 (background, border, font, etc.).


The CSS context can be defined in one of two ways:

```as3
import com.newgonzo.web.css.*:

// set it once for all future CSS instances
CSS.defaultContext = new CSS3Context();
var mycss:CSS = new CSS("p {color: #F00;}");

// set it on a per-insace basis (or override the default)
var mycss:CSS = new CSS("p {color: #F00;}", new CSS3Context());
```

# CSSView

A CSS view (`ICSSView`) is an object that acts as a bridge between your stylable data (XML, display list, etc.) and the CSS engine.
Everything that the CSS engine needs to know about your data it gets from the view. 

## Details

When the CSS engine attempts to style a node, it first gets a view for that node from the CSS context object. For example, if we're trying to
get styles for some XML node, the CSS context will return an instance of `XMLCSSView`. Views exist for XML, DisplayObjects, and arbitrary object hierarchies.