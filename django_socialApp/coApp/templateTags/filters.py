from django import template

register = template.Library()

@register.filter
def upto(value, delimiter=None):
    return value.split(delimiter)[0]

@register.simple_tag
def update_variable(value):
    print(value)
    return value