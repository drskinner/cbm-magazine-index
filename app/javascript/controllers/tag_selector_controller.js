import { Controller } from "@hotwired/stimulus"
import "tom-select"

export default class extends Controller {
  static targets = ["input", "hidden"]

  connect() {
    this.tomSelect = new window.TomSelect(this.inputTarget, {
      plugins: ['remove_button'],
      create: true,
      closeAfterSelect: true,
      onItemAdd: function() {
        this.setTextboxValue('')
        this.refreshOptions()
      },
      valueField: 'value',
      labelField: 'textContent',
      searchField: ['textContent'],
      items: this.initialSelectedValues(),
      hidePlaceholder: false,  // Make sure placeholder is visible
      placeholder: 'Type to search tags...',
      onChange: (values) => {
        this.hiddenTarget.value = values.join(',')
      },
      score: function(search) {
        const score = this.getScoreFunction(search)
        return function(item) {
          return score(item)
        }
      },
      render: {
        option: function(item, escape) {
          const searchText = this.lastQuery || ''
          if (!searchText) return `<div>${escape(item.textContent)}</div>`

          const text = item.textContent
          const index = text.toLowerCase().indexOf(searchText.toLowerCase())
          if (index === -1) return `<div>${escape(text)}</div>`

          return `<div>
            ${escape(text.substring(0, index))}
            <strong>${escape(text.substring(index, index + searchText.length))}</strong>
            ${escape(text.substring(index + searchText.length))}
          </div>`
        }
      }
    })
  }

  initialSelectedValues() {
    return this.hiddenTarget.value
      .split(/[\s,]+/)
      .filter(id => id.length > 0)
  }

  disconnect() {
    if (this.tomSelect) {
      this.tomSelect.destroy()
    }
  }
}
