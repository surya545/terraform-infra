from flask import jsonify
from . import health_bp

@health_bp.route('/health', methods=['GET'])
def health_check():
    response = {
        'result': 'Healthy',
        'error': False
    }
    return jsonify(response), 200