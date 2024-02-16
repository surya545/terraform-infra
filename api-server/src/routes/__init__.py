from flask import Blueprint

# Create blueprint
health_bp = Blueprint('health', __name__)

from . import health